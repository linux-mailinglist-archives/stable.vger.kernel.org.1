Return-Path: <stable+bounces-89576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 399259BA392
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 03:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37398B21DAC
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D9470804;
	Sun,  3 Nov 2024 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MD3cbtQn"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A69524B4
	for <stable@vger.kernel.org>; Sun,  3 Nov 2024 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730600910; cv=none; b=PyBHZk3EdFK9nI1Nmi8u6xEAnCpLmE3H4I7NsSwB19hKoqVroMhAz0HGOW8Z01sBLSuTzGow9n/Kiz+jpqG1I3M+4MYl5iPE707mum0WMsoRyw/5UJfLNCuKk/DHMHaFBcq8qjGlVrtZ/JEm2794Zdkgu6fmvx90BiQTsV33MxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730600910; c=relaxed/simple;
	bh=u41Gvl98LHPXICHm/j2dNA7EZ6rHe6Cxsqoq1nRRQEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQx07NeSp9zIs5oq/lu/jfncGrbVJ6f81H+Xd+VorARu2QknA6EK5yMllcdYaeLESHrvkJ0TLG6qnb+nzcwmL2FGY85AqUZ/dkaWiUsMp04DuO3gOKs8NUlUEhy6k+qvOVTfFjnVIhDju3cvXodbsIaOQjBMfGZB22vLMfrxTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MD3cbtQn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/meVvvFxWleynxoR8tkdaNi4/E03EZykKGliLKX9ehI=; b=MD3cbtQnG8SLDJv8GKGZ1dV28z
	G5trAu7VKXTWfw1n4jpp+bWUixbFWqG3s3UB2mOvkYVAAiUBbfXjK7qXOxVowOj3Dpi0qHKtIooBR
	wOtyDr6LjrxYVk+YvQE/PwxU0X2V5OJlXmA1/WG/t6ACNmq/BWbssxHeW53zgw8MqbgaI4mJuZoRw
	/Xjg8hFTlItg7ItOJHUwWegUnNe3zh/QFVQebcr9AM7nfSDbNeZJnjQlJ2bMQ81PXMA3pzEWbX54p
	sRShoQLjfSnVSvkXGF7SWImJETfLu1M82vBUnAs+pgJZON0NS4wHH2RmGjpYBFXldY943i3PaCsPs
	Lz69hsPA==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t7QLg-0010En-DL; Sun, 03 Nov 2024 03:28:17 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	sylv@sylv.io,
	andreyknvl@gmail.com,
	stern@rowland.harvard.edu,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: [PATCH 6.1.y / 6.6.y 0/4] Backport fix(es) for dummy_hcd transfer rate
Date: Sat,  2 Nov 2024 23:13:49 -0300
Message-ID: <20241103022812.1465647-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks, here is a series with some fixes for dummy_hcd. First of all,
the reasoning behind it.

Syzkaller report [0] shows a hung task on uevent_show, and despite it was
fixed with a patch on drivers/base (a race between drivers shutdown and
uevent_show), another issue remains: a problem with Realtek emulated wifi
device [1]. While working the fix ([1]), we noticed that if it is
applied to recent kernels, all fine. But in v6.1.y and v6.6.y for example,
it didn't solve entirely the issue, and after some debugging, it was
narrowed to dummy_hcd transfer rates being waaay slower in such stable
versions.

The reason of such slowness is well-described in the first 2 patches of
this backport, but the thing is that these patches introduced subtle issues
as well, fixed in the other 2 patches. Hence, I decided to backport all of
them for the 2 latest LTS kernels.

Maybe this is not a good idea - I don't see a strong con, but who's
better to judge the benefits vs the risks than the patch authors,
reviewers, and the USB maintainer?! So, I've CCed Alan, Andrey, Greg and
Marcello here, and I thank you all in advance for reviews on this. And
my apologies for bothering you with the emails, I hope this is a simple
"OK, makes sense" or "Nah, doesn't worth it" situation =)

Cheers,


Guilherme


[0] https://syzkaller.appspot.com/bug?extid=edd9fe0d3a65b14588d5
[1] https://lore.kernel.org/r/20241101193412.1390391-1-gpiccoli@igalia.com/


Alan Stern (1):
  USB: gadget: dummy-hcd: Fix "task hung" problem

Andrey Konovalov (1):
  usb: gadget: dummy_hcd: execute hrtimer callback in softirq context

Marcello Sylvester Bauer (2):
  usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler
  usb: gadget: dummy_hcd: Set transfer interval to 1 microframe

 drivers/usb/gadget/udc/dummy_hcd.c | 57 ++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 19 deletions(-)

-- 
2.46.2


