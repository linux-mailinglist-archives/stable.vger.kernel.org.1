Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484737BDFA9
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377113AbjJINcc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377117AbjJINcb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:32:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE11B7
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:32:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FD5C433CA;
        Mon,  9 Oct 2023 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858347;
        bh=uA4Ii6thaw1RKyKoG7hU5wA4BgxApKPt9F5KZtqsNJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IervZeCo4cwciXNgHKmdjFJfjuBTul0vYArh1LgbjKi/dhXksHNUIvZv0g+DYMzku
         NH5BJQX9yqMtvxhImSDzQZ0eebr9IlplBsRxAWY0HVqYpnDMJ1JCaQxQb01ze5g6wi
         hnF6gVT3gmj0i9M+PgQjzIHpv9wKTq4trcQanzhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 5.4 093/131] wifi: mwifiex: Fix tlv_buf_left calculation
Date:   Mon,  9 Oct 2023 15:02:13 +0200
Message-ID: <20231009130119.233415785@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

commit eec679e4ac5f47507774956fb3479c206e761af7 upstream.

In a TLV encoding scheme, the Length part represents the length after
the header containing the values for type and length. In this case,
`tlv_len` should be:

tlv_len == (sizeof(*tlv_rxba) - 1) - sizeof(tlv_rxba->header) + tlv_bitmap_len

Notice that the `- 1` accounts for the one-element array `bitmap`, which
1-byte size is already included in `sizeof(*tlv_rxba)`.

So, if the above is correct, there is a double-counting of some members
in `struct mwifiex_ie_types_rxba_sync`, when `tlv_buf_left` and `tmp`
are calculated:

968                 tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
969                 tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);

in specific, members:

drivers/net/wireless/marvell/mwifiex/fw.h:777
 777         u8 mac[ETH_ALEN];
 778         u8 tid;
 779         u8 reserved;
 780         __le16 seq_num;
 781         __le16 bitmap_len;

This is clearly wrong, and affects the subsequent decoding of data in
`event_buf` through `tlv_rxba`:

970                 tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;

Fix this by using `sizeof(tlv_rxba->header)` instead of `sizeof(*tlv_rxba)`
in the calculation of `tlv_buf_left` and `tmp`.

This results in the following binary differences before/after changes:

| drivers/net/wireless/marvell/mwifiex/11n_rxreorder.o
| @@ -4698,11 +4698,11 @@
|  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:968
|                 tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
| -    1da7:      lea    -0x11(%rbx),%edx
| +    1da7:      lea    -0x4(%rbx),%edx
|      1daa:      movzwl %bp,%eax
|  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:969
|                 tmp = (u8 *)tlv_rxba  + sizeof(tlv_rxba->header) + tlv_len;
| -    1dad:      lea    0x11(%r15,%rbp,1),%r15
| +    1dad:      lea    0x4(%r15,%rbp,1),%r15

The above reflects the desired change: avoid counting 13 too many bytes;
which is the total size of the double-counted members in
`struct mwifiex_ie_types_rxba_sync`:

$ pahole -C mwifiex_ie_types_rxba_sync drivers/net/wireless/marvell/mwifiex/11n_rxreorder.o
struct mwifiex_ie_types_rxba_sync {
	struct mwifiex_ie_types_header header;           /*     0     4 */

     |-----------------------------------------------------------------------
     |  u8                         mac[6];               /*     4     6 */  |
     |	u8                         tid;                  /*    10     1 */  |
     |  u8                         reserved;             /*    11     1 */  |
     | 	__le16                     seq_num;              /*    12     2 */  |
     | 	__le16                     bitmap_len;           /*    14     2 */  |
     |  u8                         bitmap[1];            /*    16     1 */  |
     |----------------------------------------------------------------------|
								  | 13 bytes|
								  -----------

	/* size: 17, cachelines: 1, members: 7 */
	/* last cacheline: 17 bytes */
} __attribute__((__packed__));

Fixes: 99ffe72cdae4 ("mwifiex: process rxba_sync event")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/06668edd68e7a26bbfeebd1201ae077a2a7a8bce.1692931954.git.gustavoars@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -977,8 +977,8 @@ void mwifiex_11n_rxba_sync_event(struct
 			}
 		}
 
-		tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
-		tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
+		tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
+		tmp = (u8 *)tlv_rxba  + sizeof(tlv_rxba->header) + tlv_len;
 		tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;
 	}
 }


