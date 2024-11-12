Return-Path: <stable+bounces-92831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362559C6135
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 20:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F078F285CC2
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF2219CAC;
	Tue, 12 Nov 2024 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKTjLnkc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBF20B1F7;
	Tue, 12 Nov 2024 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439130; cv=none; b=cUh8l4Su0GSExj0+Aq7OS8pmhQ0tmxmN3A/TJWjQkl7kLMKJlMvKIPUn8wtqOIttzk1I2KPBcx3uA8iVlwh8rthiM+6zcmaM6LDMuIuNKVS1+/5/gvdNSsdT4x6sSjah0P9CbpxiLKkeBg7Hyy2yFvpBTI2SsH0iDIqjIgGUbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439130; c=relaxed/simple;
	bh=t/ULDxIOnVNYpvWy2HWygKMe4lSTaPF0cPuEZyDxLl4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HRbRQYR0RlFlKJbZKSF4zBkzFrRocO5tKuX71BXc/SdWv6kE3zRZSxRn+B+rX1xOoqhtxsw+vodRFaJ8cmPxo273ngW82xAnJh7riGe6IgjzpELL2TaHPJsqxSsWflcQwJ/07vtWnt/3XXhnFMV9wLo777JVQO3PAE59GCZ5aUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKTjLnkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F8C4CECD;
	Tue, 12 Nov 2024 19:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731439129;
	bh=t/ULDxIOnVNYpvWy2HWygKMe4lSTaPF0cPuEZyDxLl4=;
	h=From:Subject:Date:To:Cc:From;
	b=PKTjLnkc60x6+hpJPk12RssWE/VaWTGWxdo6BkNmTTmLa8XtUB8MUaw19TqPy9Ey2
	 Wf7IjrRgpmKK3mR5GVSl2evQ/0G8v/VEWYQYVshHFUqRwA1EAeeWGqAvA0BZM4eHjq
	 gOxV80Qx8jLtN4r4jauHLaRSsCFx0FJWqBcSp+wOiRV493EpdHODtf1QaEKuMzieYd
	 0bwlsO7P5SOyPlXL2qQlZdDSL5/myQjKahfZMKzcgJfq6gtKF6mr804i1Wd1UXcoXV
	 LtBhS63WM2TelvCTz6yCR8olFYoUoLvEp72SL2lbVrflb8tRPiYQRaj/VEuXXglQ7d
	 hwCAiZ52xKphQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] mptcp: pm: a few more fixes
Date: Tue, 12 Nov 2024 20:18:32 +0100
Message-Id: <20241112-net-mptcp-misc-6-12-pm-v1-0-b835580cefa8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAiqM2cC/x2MQQqAMAzAviI9W1iHOOZXxIPMqj1sjk1EEP9u8
 ZhA8kDlIlxhaB4ofEmVIylQ20DY57QxyqIM1tiOiCwmPjHmM2SMUgP2qC5H9I5nw4EW7zxonAu
 vcv/jEbSB6X0/kuGWrG0AAAA=
X-Change-ID: 20241112-net-mptcp-misc-6-12-pm-97ea0ec1d979
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=t/ULDxIOnVNYpvWy2HWygKMe4lSTaPF0cPuEZyDxLl4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnM6oVkJaEmlDHyOi72cwB7OHlH+J9iqP5AL9L8
 VmVxpbUPLCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzOqFQAKCRD2t4JPQmmg
 c5niEACLFCbPPcwtLpfnh8/MaouhA8uEtW67eVX+donESp+LxYp8MN4ypfeJ20DZyTrxxsA7l5u
 l8010gwld7mEhGVKkVQTtZz2IRZR/Sb8QZa1mlnknZSRLqS2RkJMhuY1/eeNbY2p9tw+DoMkdJ0
 7i/cAvWRQps/dUYcCPqJjejH5pYfAsKasiIeGCk/Sywpo05nX1BJI0bABuYxw+wlA1MewahK5tb
 XdHD+DUSLBnKc+WxdgDXYID7gaI/hDWmaLaF/qinVd36+p2LDYpO0XcqJ29gCDna+Kto3Vr+xps
 tPNcTJx00f+v9nOt4q/GideEDD8Q/owFvuxDZHQr9rUHICe+YtuEA1uAhYobIVk75R03P3eSRz0
 C6GqxCi3UfLdrtG2pr7v0vPuf7/IM+WUgbuJlkgOi+9kiRr7PX9WFs6r+K0wIFUJkzLBiZGXyNO
 MEAVTBX/a5uBb3y4Cj2MftTnxXoJDBazwu6kgHgME7MBvAEccjC3i8Poe3bkkNqPPUO+vwnmwq0
 NrNQwwVCb8xCHp7Bw7UKHrI7Q/iQUYodG+jRLdXgupSiIHY2Ozc/j+vB53VNdEGii4m14uLnlSh
 oseBGWU2OUDgeV/Jkyzl39av0D0faO1fRPzr9UxGy9gEuALB2w1U90UoED8zbzE+Ke6uwnh+HxD
 EtJkjfkYnWeGSjA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Three small fixes related to the MPTCP path-manager:

- Patch 1: correctly reflect the backup flag to the corresponding local
  address entry of the userspace path-manager. A fix for v5.19.

- Patch 2: hold the PM lock when deleting an entry from the local
  addresses of the userspace path-manager to avoid messing up with this
  list. A fix for v5.19.

- Patch 3: use _rcu variant to iterate the in-kernel path-manager's
  local addresses list, when under rcu_read_lock(). A fix for v5.17.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (2):
      mptcp: update local address flags when setting it
      mptcp: hold pm lock when deleting entry

Matthieu Baerts (NGI0) (1):
      mptcp: pm: use _rcu variant under rcu_read_lock

 net/mptcp/pm_netlink.c   |  3 ++-
 net/mptcp/pm_userspace.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
---
base-commit: 20bbe5b802494444791beaf2c6b9597fcc67ff49
change-id: 20241112-net-mptcp-misc-6-12-pm-97ea0ec1d979

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


