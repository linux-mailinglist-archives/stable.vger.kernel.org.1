Return-Path: <stable+bounces-224612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLCXBLy7sGlXmgIAu9opvQ
	(envelope-from <stable+bounces-224612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:47:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8073B25A24C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCA9B307098B
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 00:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DB7364942;
	Wed, 11 Mar 2026 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="Q44lxkV1"
X-Original-To: stable@vger.kernel.org
Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04BA366DB9
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.196.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189861; cv=none; b=XH9KwlTS6E/9yZvH/CA6Vwg6gmSef1vYw8g55bFLLjjPizwVIeEJnvwta0fiuK1LZNEvoBx5mAEriU9glq94btBzJVpTrXqlRsC1HRc1I3ULfTbQzpdfDiUZyQEs72XVX6iQcyrU63VEIMSwhF3xdxeNmkDSkoaiXHnvJiNvobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189861; c=relaxed/simple;
	bh=bl7aXsWttulR8Cj9N7B+7S2072TKIJYXR4BxhG3BRmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qn0BHnJLZW0EOzrO0+Tpa97Mrjiu1CoAvb743K48GZNhHV4ziCfyLhz/roLEkPBnreElV/29JQeoxzntb+d2hLmLX8QCXwoAOVQ65yQVaWR/J/FRzCEnCvyT2j9IM/GOSIoVmqk2bkHcB828TMpiwYKtpoaPwEBbbMzWzwtY6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=Q44lxkV1; arc=none smtp.client-ip=135.181.196.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
	t=1773189409; bh=bl7aXsWttulR8Cj9N7B+7S2072TKIJYXR4BxhG3BRmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q44lxkV1hFko2QSoGWhr/JHXJ0nCjUwA3bfWzm0kQRoGvtkeQjd7COfDT1p1BFhkK
	 GURdpCccmsGxQ8UR7iRt/55CvabPG5XIDsF8s97Lu5ADAScDPyUuTRSelGSTnNS4Kl
	 kknccI6z1uKNXtlDWpFD0LiRi85yTcqwfp2ElLKyhr/0JB0Nq2BpgwhTktiiJ6Pw29
	 oZTmz4EZLx3RFs0F+qIVREECEWsVwqjyBN5aKXZIHo3ZX9aHX0TI6G4mOAkqHEfAYi
	 q1ppK5FgdW7VBlodMw+j744Q1DITWPbx5Sn25nsfXJ09mJaMRjDBu5DwjnaXoVqd/Q
	 AFkj6ePnf2I7g==
Received: from pliszka.localnet (83.24.17.124.ipv4.supernova.orange.pl [83.24.17.124])
	by ms.puri.sm (Postfix) with ESMTPSA id D61711F7B1;
	Tue, 10 Mar 2026 17:36:48 -0700 (PDT)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To: patches@lists.linux.dev, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Cc: Ming Qian <ming.qian@oss.nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject:
 Re: [PATCH 6.18 085/314] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
Date: Wed, 11 Mar 2026 01:36:46 +0100
Message-ID: <6892707.LvFx2qVVIh@pliszka>
In-Reply-To:
 <3b92b74f68817accc3efa8756ab3ee6bd91cefc6.1773141555.git.sashal@kernel.org>
References:
 <cover.1773141554.git.sashal@kernel.org>
 <3b92b74f68817accc3efa8756ab3ee6bd91cefc6.1773141555.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 8073B25A24C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[puri.sm,reject];
	R_DKIM_ALLOW(-0.20)[puri.sm:s=smtp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224612-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[puri.sm:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.krzyszkowiak@puri.sm,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Action: no action

On wtorek, 10 marca 2026 12:15:44 czas =C5=9Brodkowoeuropejski standardowy =
Sasha=20
Levin wrote:
> From: Ming Qian <ming.qian@oss.nxp.com>
>=20
> [ Upstream commit e0203ddf9af7c8e170e1e99ce83b4dc07f0cd765 ]
>=20
> For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
> g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
> error and produce corrupted pictures, even potentially lead to system han=
g.
>=20
> [  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
> [  110.583517] hantro-vpu 38310000.video-codec: bus error detected.
>=20
> Therefore, it is necessary to ensure that g1 and g2 operate alternately.
> This allows for successful multi-instance decoding of H.264 and HEVC.
>=20
> To achieve this, g1 and g2 share the same v4l2_m2m_dev, and then the
> v4l2_m2m_dev can handle the scheduling.
>=20
> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Co-developed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/media/platform/verisilicon/hantro.h   |  2 +
>  .../media/platform/verisilicon/hantro_drv.c   | 42 +++++++++++++++++--
>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  8 ++++
>  3 files changed, 49 insertions(+), 3 deletions(-)
>=20

This one introduces a regression that's being fixed in https://lore.kernel.=
org/
lkml/20260306031059.801-1-ming.qian@oss.nxp.com/T/, so they should probably=
 be=20
applied together once the fix lands.



