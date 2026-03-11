Return-Path: <stable+bounces-224616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEaUIz7CsGlSmwIAu9opvQ
	(envelope-from <stable+bounces-224616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:15:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B1125A4A1
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD68B305B346
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A888346A0A;
	Wed, 11 Mar 2026 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd9/arf3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0002C21E8;
	Wed, 11 Mar 2026 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773191731; cv=none; b=NdFxFyAyQYQsxRPvAEOZg0NhWm3CcPpNSNiCs9KpCMSqqpkstZkd4yR+b4xaJuunukgTXCwlmue3MdsFtiLOHyIvwCkiUB2FGNWpBkqMSW5d7D9PIsU1WCtk+PFfo3+HgaoZK1xVFA0DbMXo+/mN+3nKKVXMaNvkoSxYl8s/AZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773191731; c=relaxed/simple;
	bh=a8O5kAogHFeLlXUeLQn+xbnMj9Mfl6rgjPu4obYW4Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBY5ETLx6jAa+X3Vuu/BwSdWTKOdXpwzIBxvjVwKSlaa2p1vdwUeu0Hx5++694xWAigA07SGx697QOge8IO+1L7xc5t8ENc9YM3uMTcU7prVCaHZZ6xnSR7tRVg49vWlwXpb6afBJBpR39GS2rUN2ra75t27KLDYYcfKFykLMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd9/arf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AABC2BC87;
	Wed, 11 Mar 2026 01:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773191730;
	bh=a8O5kAogHFeLlXUeLQn+xbnMj9Mfl6rgjPu4obYW4Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pd9/arf3xCTnkWP/72myu2UxYA3SDFiHpoE5eX9deajMP8XGY8PhiYg/IGmnnuXsf
	 /WpJcNI8JPRuzKZGh6BBzQiize0m5PHcAXwVtCoVj3uDkDlfruJrCTAHBnoHShOFn4
	 3dB+uarG72uEK6K/neSk8mfme0+eHcONhN69OJ0P1CjTRGefCzb36OtOotW/20dNhN
	 HmaZ/qQFj61PkN0X7z+y6ToruDqjLpu0Sw1SIXu3/KVxslDcbCWo6mSU84uR/Sh7mJ
	 33auLjCFOC2w+JHuSfKUVDYeoK5Knt+OcU42Qfe3bHEgoEa2YAm/2EwYOm9ETnwS1u
	 oYqpIiJhtASMQ==
Date: Tue, 10 Mar 2026 21:15:29 -0400
From: Sasha Levin <sashal@kernel.org>
To: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Ming Qian <ming.qian@oss.nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 6.18 085/314] media: verisilicon: Avoid G2 bus error
 while decoding H.264 and HEVC
Message-ID: <abDCMeP7QGNNHCLB@laps>
References: <cover.1773141554.git.sashal@kernel.org>
 <3b92b74f68817accc3efa8756ab3ee6bd91cefc6.1773141555.git.sashal@kernel.org>
 <6892707.LvFx2qVVIh@pliszka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6892707.LvFx2qVVIh@pliszka>
X-Rspamd-Queue-Id: 44B1125A4A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224616-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,collabora.com:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 01:36:46AM +0100, Sebastian Krzyszkowiak wrote:
>On wtorek, 10 marca 2026 12:15:44 czas środkowoeuropejski standardowy Sasha
>Levin wrote:
>> From: Ming Qian <ming.qian@oss.nxp.com>
>>
>> [ Upstream commit e0203ddf9af7c8e170e1e99ce83b4dc07f0cd765 ]
>>
>> For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
>> g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
>> error and produce corrupted pictures, even potentially lead to system hang.
>>
>> [  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
>> [  110.583517] hantro-vpu 38310000.video-codec: bus error detected.
>>
>> Therefore, it is necessary to ensure that g1 and g2 operate alternately.
>> This allows for successful multi-instance decoding of H.264 and HEVC.
>>
>> To achieve this, g1 and g2 share the same v4l2_m2m_dev, and then the
>> v4l2_m2m_dev can handle the scheduling.
>>
>> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> Co-developed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/media/platform/verisilicon/hantro.h   |  2 +
>>  .../media/platform/verisilicon/hantro_drv.c   | 42 +++++++++++++++++--
>>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  8 ++++
>>  3 files changed, 49 insertions(+), 3 deletions(-)
>>
>
>This one introduces a regression that's being fixed in https://lore.kernel.org/
>lkml/20260306031059.801-1-ming.qian@oss.nxp.com/T/, so they should probably be
>applied together once the fix lands.

I can drop it from 6.18<=, but note that it was already released as part of
6.19.

We can revisit a revert or cherry picking the fix for 6.19 after the current
release cycle.

-- 
Thanks,
Sasha

