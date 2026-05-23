Return-Path: <stable+bounces-253962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q2dPCPPYEWqBrQYAu9opvQ
	(envelope-from <stable+bounces-253962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:42:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 695865BFDDB
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C122F300A385
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF977318ED2;
	Sat, 23 May 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b="ivq6yF+K"
X-Original-To: stable@vger.kernel.org
Received: from out198-191.us.a.mail.aliyun.com (out198-191.us.a.mail.aliyun.com [47.90.198.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CC2C08AC
	for <stable@vger.kernel.org>; Sat, 23 May 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554541; cv=none; b=DfTrlbFrAeIatwnN1LhcKkPgP2auhQWtMsUZ220/FdYc/q3l22P49FJDOcDBil1Zal9CQSjV+sXdFgEoKdSu+mY5JesGslnlddli+MWlmCVsZQejzg1z7yzDUhCLsFj1QklMn14O36zgxgZhmynAEgRtGDAWdCDuKwz+malEXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554541; c=relaxed/simple;
	bh=s3SlEA4IVXkKS1Ai1U5kyfbKObEnJpdC/pYUM5dBT6M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f20Qz+SSHrLCbtOg+e9Wg8chKXDXJ1zF14YY9mclZTCBw11DrVxEe+IV//mVJlXO2rfM2KKHMHDGxYCL4bptEMeETI+ulMZTYkaFyTNKgQCaQH9FHpVpYs6r6sc896yy/Nn7PyhTzVGjjN7UEaoP2ieBqGzNPOo9Wcrbb91IKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc; spf=pass smtp.mailfrom=alancui.cc; dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b=ivq6yF+K; arc=none smtp.client-ip=47.90.198.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alancui.cc
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1779554528; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=yvXzh8hM4d0CXSabynJP/0WIH+Kcu2C/+Q86UyNHIJE=;
	b=ivq6yF+KiF9/nyA03PK9NkTTwAcvJaQbIzVwvawP42iUxTPGz4T0HtAr5J2gYIoUP8hTuxIFtdNNnmE204Sq+qZj1RkHBeEWDvohQneK6knFhum2se/DjKXzp4xjX8vsxqOTrfgrqW/8lAe030kxBzNvH45ZazNCYJ9GzqSMrvqxEUOgSVAB4JHgNG7WKImM+y/qZraFXU21Yc0mtG6HkLw+wG7NmrU3w/bo23XfVSgF13Bno3LnPqZf3wIDj9YiG7FM+EmNWs5mHlftwPuakHAAPIyIY1bNVKHV2kx16We5hiuT7RxIWXqxi6/Aa8TXu5rf3Ek6C2YzlMQ0eELwKQ==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2593195|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00956912-0.00307263-0.987358;FP=8169554571554234116|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=me@alancui.cc;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.hevDCcJ_1779547237;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hevDCcJ_1779547237 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 23 May 2026 22:40:38 +0800
From: AlanCui4080 <me@alancui.cc>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Keith Busch <kbusch@kernel.org>
Subject:
 Re: Patch "nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808
 (Samsung PM981/983/970 EVO Plus )" has been added to the 7.0-stable tree
Date: Sat, 23 May 2026 22:40:37 +0800
Message-ID: <9hBwPrIRQFOSOc3QwbVPmQ@alancui.cc>
In-Reply-To: <20260523143029.590331-1-sashal@kernel.org>
References: <20260523143029.590331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alancui.cc,reject];
	R_DKIM_ALLOW(-0.20)[alancui.cc:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[alancui.cc:+];
	TAGGED_FROM(0.00)[bounces-253962-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@alancui.cc,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alancui.cc:email,alancui.cc:mid,alancui.cc:dkim]
X-Rspamd-Queue-Id: 695865BFDDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Saturday, 23 May 2026 22:30=EF=BC=8CSasha Levin wrote=EF=BC=9A
> This is a note to let you know that I've just added the patch titled
>=20
>     nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808 (Samsung P=
M981/983/970 EVO Plus )
>=20
> to the 7.0-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      nvme-add-quirk-nvme_quirk_ignore_dev_subnqn-for-144d.patch
> and it can be found in the queue-7.0 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20
>=20
> commit e86bd12c5a99ae20455deaa902dc8ab755d9f1e7
> Author: Alan Cui <me@alancui.cc>
> Date:   Thu Apr 9 16:15:25 2026 +0800
>=20
>     nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808 (Samsung P=
M981/983/970 EVO Plus )
>    =20
>     [ Upstream commit 7f991e3f9b8f044640bcb5fa8570350a68932843 ]
>    =20
>     The firmware for Samsung 970 Evo Plus / PM981 / PM983 does not suppor=
t SUBNQN.
>     Make quirks to suppress warnings.

This commit is actually a mistake and is reverted in 7.1-rc4.

https://lkml.org/lkml/2026/5/17/896
AlanCui4080 (1):
      Revert "nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808"

Sorry I'm new to the kernel, and i don't know how "backport" works, but sin=
ce
this commit is a mistake, so should it to be not merged into the stable?

Alan.



