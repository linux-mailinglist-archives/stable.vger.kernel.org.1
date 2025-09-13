Return-Path: <stable+bounces-179428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E7B5609C
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5F17A51CC
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C954A283FF0;
	Sat, 13 Sep 2025 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tgk/TZri"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792E26FA54
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757765990; cv=none; b=D5JNQnvIEAU5ge7c8sOrAEOU1vYKrqTIKqPCvw3LNRh9kdSvxBAvp8sNippfbG6JcQlHIUNTGeYOmkGnoKxzIM8BnaM0ZR/WyUwAnl8pitGlpsRk0Dc72iYyHce1DuAL5YW7NqzNGY9VuJ5tfr04rCFBH/dNuG5IGjmABEFzEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757765990; c=relaxed/simple;
	bh=Sfqt9XSNiDI0Y8rqRolQKq6+KT+oavx+2rHRvw1D+kE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qc94uWEFs3D9dAWGuatCrZqWoki2Z2EjSyCVUVICoxzSS2ua8eT+cGtFPa7vxLrysvuFfDnMvfqy+9x328nPwI4MeSKTeL3pI9GiS+wQ9XC0ZiMiQpsohDsuR42deEUa1qgq0iDjatOG7zqNLusYGYusRhhvBEJ94ZV1eXx9Jm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tgk/TZri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C073DC4CEEB;
	Sat, 13 Sep 2025 12:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757765990;
	bh=Sfqt9XSNiDI0Y8rqRolQKq6+KT+oavx+2rHRvw1D+kE=;
	h=Subject:To:Cc:From:Date:From;
	b=Tgk/TZriQ0JdYLY+Ftm0DU3yNn2f+i8Fi67YcL8+o0k8JhGxXsRANlbKlJdRRoVYY
	 pnv7IeNLCFE4RlfosOLonp7Na3RHRqyikEx6rvfpPr3C9MfH6MwtQaZXzQhgwPT5lA
	 +ZYhU6FBUCn6/RyGKrjIHTiZOiTFFPzpYldLkoGI=
Subject: FAILED: patch "[PATCH] netlink: specs: mptcp: fix if-idx attribute type" failed to apply to 6.12-stable tree
To: matttbe@kernel.org,geliang@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:19:47 +0200
Message-ID: <2025091346-avenue-afterglow-5b42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7094b84863e5832cb1cd9c4b9d648904775b6bd9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091346-avenue-afterglow-5b42@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7094b84863e5832cb1cd9c4b9d648904775b6bd9 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 8 Sep 2025 23:27:27 +0200
Subject: [PATCH] netlink: specs: mptcp: fix if-idx attribute type

This attribute is used as a signed number in the code in pm_netlink.c:

  nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))

The specs should then reflect that. Note that other 'if-idx' attributes
from the same .yaml file use a signed number as well.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250908-net-mptcp-misc-fixes-6-17-rc5-v1-1-5f2168a66079@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 02f1ddcfbf1c..d15335684ec3 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -256,7 +256,7 @@ attribute-sets:
         type: u32
       -
         name: if-idx
-        type: u32
+        type: s32
       -
         name: reset-reason
         type: u32


