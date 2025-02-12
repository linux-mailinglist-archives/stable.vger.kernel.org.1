Return-Path: <stable+bounces-115056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1A8A327FC
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 15:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9629D3A4F15
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED020F067;
	Wed, 12 Feb 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hjO6sgQv"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31F20E714;
	Wed, 12 Feb 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369278; cv=none; b=drFPav8JGA7YSSnnpqI+tWZ4xZVpphojW6vjYLgys7DcDvbhybl/PoJUvFoR6lUMp6/MjrcYi0SAbIUxI3SbNgofTMsL813OXTbiTXQE/CzmGeX5Goj45eNilTpAdPj31Pod8w/CstONoDUA2HOXSdiF34aeF0QHIe0MT53qnr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369278; c=relaxed/simple;
	bh=KW6EoMcTxAn8bpbomq95y0xiTqFHJk2QJNNPeo6PjAg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=njl9hT29lj5qOh9wVSRF/EJGa1paaQZtjXXowywcl+UBf6K8RTjPERdT4zCj++IsjgBRpx9O1rcieTlXN3nLDSkpAHEu/Cngr3VPBqJ7VrCX6rOvlfSW3ZYhWDLu/PtVTP2+Ape5rMtzm5KFACmyXjbB3gVqt03KJZeavXCO0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hjO6sgQv; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739369246; x=1739974046; i=markus.elfring@web.de;
	bh=KW6EoMcTxAn8bpbomq95y0xiTqFHJk2QJNNPeo6PjAg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hjO6sgQvHT1s1mwxQ5wRc9loVCtkqy46bKfiNbAZ/X26rZwY51HqZ6mGFqqGpojt
	 nXVfnvslqemdkoE07RjwKVaj0Jnjb/zjh5Zg8R54q13N23MPcLspIC8br8kA5nBji
	 5va4Eu008iZZee+FZ4z0KDa7fG2EvavXJn6hPqvOrDGKsHKwViDJT11wrNHESp8Eg
	 4Ko3AA/tx7k9/xHUbFnezfwedoz9Pmpu9UfLzb371NMezxD/JhwDW5K7MSzSdC0Ae
	 D/YFKCxWe6UW0AIP3e/ZTqGEKKIJnq43GuMnfiENJnbvbLR58ociewBRaY9yMNSGU
	 Alxds+7cAb4Z/617yA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidHP-1tD1VR2yqV-00ZeSO; Wed, 12
 Feb 2025 15:07:26 +0100
Message-ID: <a5e45ae1-2c87-46c6-8a30-3186e304aea3@web.de>
Date: Wed, 12 Feb 2025 15:07:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Boris Pismenny <borisp@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250212025351.380-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] tls: Check return value of get_cipher_desc in fill_sg_out
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250212025351.380-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OyRS4JtDglS3wh7qHezxVJJ8DeVA4HoAipLGoKUHTjBsfCNJ38A
 FLJpAwgYgb2v8mWJUOdNdFg/pCOtNKcCa/kY4iwHVKihiDY7/C/K+r8g5egLF9PD+M55Cby
 +N/VOd9sWjxDWvAorvdfjlblGGAhYNJFFwrwoNMCv0QQNPdOBt0CD9BM+GnJ1kF7ca+KxUw
 mAtuiJ5A+jXowkVFf7wLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rp2tZqP2nWg=;juVcFpIADULyBfYC+BrOBDJknvW
 fpqwVziY02Bzrj9bvxoL0rpXy0rnXFT+S3AK82PHyUvhYpYPbShxIKYtSrVYrrNbBBQ/mOufw
 YdB3yIlwsIV1MAMA45iSFX3Clm7zlxur8mdWrjsq2pnScLsNiv/ZZjtfOnzw7S2Rvyp4g3g/s
 V4MWP/J0XHYWWbxpnI1DlE4xqUlL53t+dpGxdMW1rSzGZ/qibucWrLTQGKU3G/a9PEX4ImzDT
 pJ8TFzYHWHVM1okX05K48iUGymBz8Tb1aCrzfbSrvoQL/anRLH17b2wy5AyJXnjawDPmvgdpx
 95IxYPb7MjMdVNRQIi78ZA2A9VABk7FAafHbxnMM+HR5A75/uvIdUf+YOS09WHJMGkVRmM+wX
 N5PTURcgCDsZ1lAgczhdEolun+4SWx9Dnu717dcH+ruBrUK5cY8EroPkosSLq8Pd9FHoHti4b
 1ismg+R2ytzPC6Z9ke2PpxYkHTTZryY4Rm594+qGIcgik/3g0SMEfUBaiQWYBGDsKfnz9BVKK
 vT5YYvwkQ4kZ6uOtPC4Ky1ZTHvwCIOg1OCrSvw5I1TdjlcHoiT4rW007eOkty7xUTGj/S0TAt
 2KPHbJVpclAtpigQHJ2zTFzvFP6HqUqLpMpBFz+pix63xYTr65l5HxsYa6fhJoNjDM3fP6ogF
 8RuS/rWMbUiSOPTxgjdI6h5GsIo9xrUeLiXEKdjDG4q6QrNHCbFTPW6osYVPbiyVrft4A8w6V
 QYZlqi3LM+52sMnBhL0s6UNfNeqm8lPVEudhOtDEFnuR4CjTHRstS7On41NQdLZLlhokZeBxv
 5ear/sQyMe105MlOCWuS8T+CoUTEPAcIIdrd9T+O5lv0IEfFMujmLQXnx0CgKq8pYD7RV7GaY
 m5DRN4R4NcBaADUm3yE3+37/gD4hMQDILA1d1M8H1pMA+cZ8TG0TH2x7IlHmfGUoKdawXEzGA
 2AOh0oLoQsfzK6c5wOvC6RsDozh8eTN3kprSifUB2qn/nAnqKXPJc2GXgkjDk+7OunQxyftEE
 RU/BHAaDzd7RflCyOlpxl47NEo7hLLDSjTj7HLy1Rv8AMa/vKcqzuwhEPJSmS+npFHzwHM4y5
 /0CM8AYX7J+KPy/40f2lpR3XHwcscgB+g62ar9lyI7Ce/Lcrweopk6mvA//HLHp93sQhdg5A1
 /4StARMEnUU8p9Kxh2oL6oOT8CZFpBmUC5LrfSskyRHHNrzC8Lr8zkcMHcXVfuPgm1FHDlqm4
 G0er7/SqPbcY0qsbb5nh6JaPeypUFh5l8nmpxLq1TX2TUOmTotc3ol3Bd/TQcuiz4yJIIwq9w
 +/ynyeTjTTRkIeU/UrOLifTanfvQ7njX262kYfbPtrpi6ZCxwmr8PSWTsa7+hSshP2O+y2G/2
 VsFjSv1WCWrhySbZ6zfX9fxbvjgqeIP6H1anmxsNuraIF4SK5HJe5wSxOw3xU6BsTRJ5IgLj1
 JmspxBP1UrOL66pd///eiziO4v9c=

=E2=80=A6
> This patch adds a DEBUG_NET_WARN_ON_ONCE check =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc2#n94


Would you like to append parentheses to any function names?

Regards,
Markus

