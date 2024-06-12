Return-Path: <stable+bounces-50310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D26CE905A49
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 19:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4FDB21DAB
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1533181BBD;
	Wed, 12 Jun 2024 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E1IasHeo"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E0183061
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215028; cv=none; b=Y7MWfgkyTi2aK4nhLTr50vHCDP74RSzel8Pn2pHD2TIttPhIdRjafx6z562BjotHaUm1RbnYmFVJ6W4gtbobH39PE1/1UqtBTGpKVVxjaurEJLBegBG7Xr1OfHg7MwONSSclN3mLcryQ130z1kNM5phkEUboE+HC4yLisSwq898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215028; c=relaxed/simple;
	bh=St+sMYNTCoqvRR9o4TOgT+hmqceOoipXhCWds/kX9V8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=hNH5JB4Do6o+qC/zdlm0JgCoPU2pgt1lAwoe3uePJzgPaZd1fD6NWzpzPGp/x9oifBgmunc1zr2Jv12Pf1pyqQ99KUrWE1TFnO7Zzy6z9dwticyd5RmElBX+wwff94BCCEKbZ+CLroAWekJxKjrpMxM4c4InLELtdTQQ0CpoqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E1IasHeo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD00120B7001;
	Wed, 12 Jun 2024 10:57:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD00120B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718215026;
	bh=St+sMYNTCoqvRR9o4TOgT+hmqceOoipXhCWds/kX9V8=;
	h=From:Subject:Date:Cc:To:From;
	b=E1IasHeoPoKEwZfHwktm3k1lyyRwSyMA1tzUcrXwBM4F6jZUraS0x6gUXcV0OMBai
	 T3h1rGnNamlthiZj5GWar3QtstpUWJoNWXqn5zYeNKHZTlnfJojY8LXnjjN95p+iyH
	 5tRZclXr5U6dz0NIabHb6w6ssccylaxQ/tCzioHo=
From: Allen Pais <apais@linux.microsoft.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Regression Impact from Commit dceb683ab87c on Kubernetes Hairpin
 Tests
Message-Id: <AD9EB3AD-7A36-4E54-9BEC-02584A4DF11E@linux.microsoft.com>
Date: Wed, 12 Jun 2024 10:57:03 -0700
Cc: stable@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3774.600.62)

Hi Greg,

I hope this message finds you well. I'm reaching out to report a =
regression issue linked
to the commit dceb683ab87c(v5.15.158), which addresses the netfilter =
subsystem by skipping
the conntrack input hook for promiscuous packets.=20

[dceb683ab87c 2024-04-09 netfilter: br_netfilter: skip conntrack input =
hook for promiscuous packets.]

Unfortunately, this update appears to be breaking Kubernetes hairpin =
tests, impacting the normal
functionality expected in Kubernetes environments.

Additionally, it's worth noting that this specific commit is associated =
with a security vulnerability,
as detailed in the NVD: CVE-2024-27018.=20

We have bisected the issue to the specific commit dceb683ab87c. By =
reverting this commit,
we confirmed that the Kubernetes hairpin test issues are resolved. =
However, given that this commit=20
addresses the security vulnerability CVE-2024-27018, directly reverting =
it is not a viable option. We=E2=80=99re=20
in a tricky position and would greatly appreciate your advice on how we =
might approach this problem.

Thank you for your attention to this matter. I look forward to your =
guidance on how we might proceed.


Best regards,

Allen=

