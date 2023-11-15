Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2D7E23C2
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjKFNOR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjKFNOP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:14:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2759EBD
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:14:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C25AC433C8;
        Mon,  6 Nov 2023 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276452;
        bh=6+wlVBGRQxtU27NziEqZm9B1cgHc/FWVywSde2t0ABE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=172J+2toi5PQSygOCX3HmYgFPAaqiw7bSvJRIHEdiS0N2lzXe/pXtmynAmEqMm19w
         BwrEcPoA18gY3KnGXeo5MJ7WfOIBa6ggMK0RoJt1/AmwKp3FFK7jYTGhh6u19AFP0r
         hDYX3r+O0kTbx1WDrwcUTjF1JVTrMohvloH7asCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jimmy Hu <hhhuuu@google.com>
Subject: [PATCH 6.1 48/62] usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()
Date:   Mon,  6 Nov 2023 14:03:54 +0100
Message-ID: <20231106130303.508847512@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jimmy Hu <hhhuuu@google.com>

commit 4987daf86c152ff882d51572d154ad12e4ff3a4b upstream.

It is possible that typec_register_partner() returns ERR_PTR on failure.
When port->partner is an error, a NULL pointer dereference may occur as
shown below.

[91222.095236][  T319] typec port0: failed to register partner (-17)
...
[91225.061491][  T319] Unable to handle kernel NULL pointer dereference
at virtual address 000000000000039f
[91225.274642][  T319] pc : tcpm_pd_data_request+0x310/0x13fc
[91225.274646][  T319] lr : tcpm_pd_data_request+0x298/0x13fc
[91225.308067][  T319] Call trace:
[91225.308070][  T319]  tcpm_pd_data_request+0x310/0x13fc
[91225.308073][  T319]  tcpm_pd_rx_handler+0x100/0x9e8
[91225.355900][  T319]  kthread_worker_fn+0x178/0x58c
[91225.355902][  T319]  kthread+0x150/0x200
[91225.355905][  T319]  ret_from_fork+0x10/0x30

Add a check for port->partner to avoid dereferencing a NULL pointer.

Fixes: 5e1d4c49fbc8 ("usb: typec: tcpm: Determine common SVDM Version")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
Link: https://lore.kernel.org/r/20231020012132.100960-1-hhhuuu@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1616,6 +1616,9 @@ static int tcpm_pd_svdm(struct tcpm_port
 			if (PD_VDO_VID(p[0]) != USB_SID_PD)
 				break;
 
+			if (IS_ERR_OR_NULL(port->partner))
+				break;
+
 			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
 				typec_partner_set_svdm_version(port->partner,
 							       PD_VDO_SVDM_VER(p[0]));


