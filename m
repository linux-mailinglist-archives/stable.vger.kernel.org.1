Return-Path: <stable+bounces-208018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC99D0F208
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 15:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A37ED30478EA
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C453491D3;
	Sun, 11 Jan 2026 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qXu1OOAz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465834889C;
	Sun, 11 Jan 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768141981; cv=none; b=IQ4Ui8cOJa6aydqgz04hn1YpNyEZVGmU6dOO3O81jPl3y0dbA97DZIGq/R8QHS51JYzieC778mfF3dEXY+nkrXAfeZpbEuKmO8WuR+GslDg/qvsguYhwPmGkXjiUjcZp66WL+qmj9rYG0rwQ8YZks69Zalmji+lp4CNLNrLVa2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768141981; c=relaxed/simple;
	bh=/2X9bjhXAP33HdGKkvA7jsK+5LOftddiJFI5ATQeuls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlFuN74Cb8/5e4ZULSivjcc7EwFt0b5ro0xixmoK8xD+aqE0qdMK0/WywBChqkMCD7vrOiUrtHeKb3KvW6uuMuDpc5+pvp1tncsQDzrptjE8RLoDecG+AMlEllI8vBfVmE3PpFurBCwY6C3L3o75Kt4r6TcTvjNCgOymZ3xaBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qXu1OOAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D90FC4CEF7;
	Sun, 11 Jan 2026 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768141980;
	bh=/2X9bjhXAP33HdGKkvA7jsK+5LOftddiJFI5ATQeuls=;
	h=From:To:Cc:Subject:Date:From;
	b=qXu1OOAz7vZoMET0wxHizaHdT35dM9AtjTV/UCtx6QcDvX+dsw+N8nwIpHc6qIMUF
	 5VEa+damiXAc5+F5+hKCqhhCM2Y3pa/0XDjRVDj8IkvgPUDwAW4RBtiq4valiqbycr
	 FebQDh/iL0BjniuzGpGC9/zxESjYCzItEZZSnkmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.5
Date: Sun, 11 Jan 2026 15:32:52 +0100
Message-ID: <2026011153--8151@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.5 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                       |    2 -
 fs/nfs/localio.c               |   12 +++----
 include/linux/sched/topology.h |    3 +
 kernel/sched/core.c            |    3 +
 kernel/sched/fair.c            |   65 +++++++++++++++++++++++++++++++++--------
 kernel/sched/features.h        |    5 +++
 kernel/sched/sched.h           |    7 ++++
 kernel/sched/topology.c        |    6 +++
 net/mptcp/protocol.c           |    8 +++--
 net/mptcp/protocol.h           |    3 +
 10 files changed, 91 insertions(+), 23 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.18.5

Mike Snitzer (1):
      nfs/localio: fix regression due to out-of-order __put_cred

Paolo Abeni (1):
      mptcp: ensure context reset on disconnect()

Peter Zijlstra (3):
      sched/fair: Small cleanup to sched_balance_newidle()
      sched/fair: Small cleanup to update_newidle_cost()
      sched/fair: Proportional newidle balance


