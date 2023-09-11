Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF6A79BDDE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355746AbjIKWBu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239602AbjIKOYZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:24:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA7DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:24:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8786C433C8;
        Mon, 11 Sep 2023 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442260;
        bh=9g8Sg1IlEtqrCSBAB0MFkzwDr6J1Mrg2kkE4MldwLGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNQy9LUciy8VAaek6jVKNfvP+wX6LZVOnIWwgplMzwJC23PGzD6y554hu7P2Y/VI2
         r27gdZW+jURaMRPBkvdjsXrvBE0kxdsg9cTNmNHuKDzqX37yTBYgjNM6riSvF6yIRr
         Mrg6li+djJ9/yvYFZAPviK4lxmSha4ihYtDVcDC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Ash Holland <ash@sorrel.sh>
Subject: [PATCH 6.5 676/739] ALSA: seq: Fix snd_seq_expand_var_event() call to user-space
Date:   Mon, 11 Sep 2023 15:47:55 +0200
Message-ID: <20230911134709.982682525@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 86496fd4a2fabb7c978fdaca2d4b718207a96d36 upstream.

The recent fix to clear the padding bytes at
snd_seq_expand_var_event() broke the read to user-space with
in_kernel=0 parameter.  For user-space address, it has to use
clear_user() instead of memset().

Fixes: f80e6d60d677 ("ALSA: seq: Clear padded bytes at expanding events")
Reported-and-tested-by: Ash Holland <ash@sorrel.sh>
Closes: https://lore.kernel.org/r/8a555319-9f31-4ea2-878f-adc338bc40d4@sorrel.sh
Link: https://lore.kernel.org/r/20230905052631.18240-1-tiwai@suse.de
Link: https://lore.kernel.org/r/20230905081210.6731-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/seq/seq_memory.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -187,8 +187,13 @@ int snd_seq_expand_var_event(const struc
 	err = expand_var_event(event, 0, len, buf, in_kernel);
 	if (err < 0)
 		return err;
-	if (len != newlen)
-		memset(buf + len, 0, newlen - len);
+	if (len != newlen) {
+		if (in_kernel)
+			memset(buf + len, 0, newlen - len);
+		else if (clear_user((__force void __user *)buf + len,
+				    newlen - len))
+			return -EFAULT;
+	}
 	return newlen;
 }
 EXPORT_SYMBOL(snd_seq_expand_var_event);


