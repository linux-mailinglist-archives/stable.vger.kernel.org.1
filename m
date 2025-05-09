Return-Path: <stable+bounces-143021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70895AB0DE1
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72F81BA1025
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C672741D0;
	Fri,  9 May 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cWwOKbQr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64A21FF23
	for <stable@vger.kernel.org>; Fri,  9 May 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780977; cv=none; b=e8G8VYC/IpjEq0RHzSeaT+4oJgrZr5QeLiCQzj7XeeJNHwwUymEJU38VCQTtJ7XOIbq3uZ5TwbepoBvDI9KzNXKDrps9g8YvV0XArHcqxpni4uFBQfydf3supc2MoKxdBryip+n6Dz+HtWg+fWV6/pBH+zO/GBjQtcHe30ZVBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780977; c=relaxed/simple;
	bh=gFEWM9T1QNlZi9sO4xAojwdoSkLmQ6YPuQaTDgdu888=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qx3NCkSpQOis34zikLHhxDhlB21sxV7T+9hIHscueASP2FujqRVc1TpOgyTqCHcxISWO9Ss4Bhxt/SEJuO1htIU/y1tbF2j+XoXfSvtfHMLqGvumiJzSr4YbUnEmU82T8hKDJ6psdm0mPq7z/4Fd4SX4qlnQAiTDP/YknoEdyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cWwOKbQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3C9C4CEE4;
	Fri,  9 May 2025 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746780977;
	bh=gFEWM9T1QNlZi9sO4xAojwdoSkLmQ6YPuQaTDgdu888=;
	h=Subject:To:Cc:From:Date:From;
	b=cWwOKbQrOyRKYTvTdPF+0zgMS0dMueDJ+va7lzNC9UjvtICU1Bl86ZRAFtkb3KQfD
	 dONA2NvtVl+PidKXrdbRIWkr3+PZ5RrcA4x4yHTFvLCjKE4YUDoVr91fjcIcfz0lJK
	 B1f4mvtuzjw7NT19Iw+/LN3DwDvHGi9O1uHYCn9o=
Subject: FAILED: patch "[PATCH] openvswitch: Fix unsafe attribute parsing in" failed to apply to 5.4-stable tree
To: echaudro@redhat.com,aconole@redhat.com,i.maximets@ovn.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 09 May 2025 10:56:13 +0200
Message-ID: <2025050913-rubble-confirm-99ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 6beb6835c1fbb3f676aebb51a5fee6b77fed9308
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050913-rubble-confirm-99ee@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6beb6835c1fbb3f676aebb51a5fee6b77fed9308 Mon Sep 17 00:00:00 2001
From: Eelco Chaudron <echaudro@redhat.com>
Date: Tue, 6 May 2025 16:28:54 +0200
Subject: [PATCH] openvswitch: Fix unsafe attribute parsing in
 output_userspace()

This patch replaces the manual Netlink attribute iteration in
output_userspace() with nla_for_each_nested(), which ensures that only
well-formed attributes are processed.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
Acked-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 61fea7baae5d..2f22ca59586f 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -975,8 +975,7 @@ static int output_userspace(struct datapath *dp, struct sk_buff *skb,
 	upcall.cmd = OVS_PACKET_CMD_ACTION;
 	upcall.mru = OVS_CB(skb)->mru;
 
-	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
-	     a = nla_next(a, &rem)) {
+	nla_for_each_nested(a, attr, rem) {
 		switch (nla_type(a)) {
 		case OVS_USERSPACE_ATTR_USERDATA:
 			upcall.userdata = a;


