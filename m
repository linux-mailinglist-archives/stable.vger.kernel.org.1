Return-Path: <stable+bounces-176454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF302B379D4
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 07:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A96B77A6CDF
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 05:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C71F30F94B;
	Wed, 27 Aug 2025 05:29:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302702676E9;
	Wed, 27 Aug 2025 05:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272594; cv=none; b=hjGfvYO4BKCjuRcow8uEjPUiyJuuKeyad1TDYynC+7pv7vN4q2uq18K8OTtH0Hl2UPDPKAiHMjOoTVEAs0fBH3nacc6kDfvhetc1KA8jo3z6uvxKz1PKWfBSqn3q/qqWyyVVE1GvUJOpb3dxFIMWPO3FsZfTHv6Ldf9or+kFWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272594; c=relaxed/simple;
	bh=iO5c6R3KlLJg5tv8rKsvYkFO3/XWQS6AM/LFiEJbIE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmzn/H2rbHMclsgetYLh4sTt8B7sDUI50RGuXMv3WmzBS73zSz3HYP6mk8gVnG3e9426zy7sH0z7Qc80wntAaMIHWNJEbPmC+1Eo/3DuqS/K9IPTof7j7fNIOrAaBLcEtkv1I2H8RjkqPgRKtyPTK6H4BGQrhFg2b69KXK78kow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5b13a549.dip0.t-ipconnect.de [91.19.165.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AF60260213B1A;
	Wed, 27 Aug 2025 07:29:36 +0200 (CEST)
Message-ID: <8802b5d1-abf1-4ceb-8532-7d8f393f1be6@molgen.mpg.de>
Date: Wed, 27 Aug 2025 07:29:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 RESEND] Bluetooth: btintel: Correctly declare all
 module firmware files
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
 Dimitri John Ledkov <dimitri.ledkov@canonical.com>, stable@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
References: <20221122140222.1541731-1-dimitri.ledkov@canonical.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20221122140222.1541731-1-dimitri.ledkov@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Daan,


Thank you for the patch.

Am 26.08.25 um 22:29 schrieb DaanDeMeyer:
> From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> 
> Strictly encode patterns of supported hw_variants of firmware files
> the kernel driver supports requesting. This now includes many missing
> and previously undeclared module firmware files for 0x07, 0x08,
> 0x11-0x14, 0x17-0x1b hw_variants.
> 
> This especially affects environments that only install firmware files
> declared and referenced by the kernel modules. In such environments,
> only the declared firmware files are copied resulting in most Intel
> Bluetooth devices not working. I.e. host-only dracut-install initrds,
> or Ubuntu Core kernel snaps.
> 
> BugLink: https://bugs.launchpad.net/bugs/1970819
> Cc: stable@vger.kernel.org # 4.15+
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
> Notes:
>      Changes since v4:
>      - Add missing "intel/" prefix for 0x17+ firmware
>      - Add Cc stable for v4.15+ kernels
>      
>      Changes since v3:
>      - Hopefully pacify trailing whitespace from GitLint in this optional
>        portion of the commit.
>      
>      Changes since v2:
>      - encode patterns for 0x17 0x18 0x19 0x1b hw_variants
>      - rebase on top of latest rc tag
>      
>      Changes since v1:
>      - encode strict patterns of supported firmware files for each of the
>        supported hw_variant generations.
> 
>   drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index a657e9a3e96a..d0e22fe09567 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2656,7 +2656,25 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
>   MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
>   MODULE_VERSION(VERSION);
>   MODULE_LICENSE("GPL");
> -MODULE_FIRMWARE("intel/ibt-11-5.sfi");
> -MODULE_FIRMWARE("intel/ibt-11-5.ddc");
> -MODULE_FIRMWARE("intel/ibt-12-16.sfi");
> -MODULE_FIRMWARE("intel/ibt-12-16.ddc");
> +/* hw_variant 0x07 0x08 */
> +MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
> +MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
> +/* hw_variant 0x0b 0x0c */
> +MODULE_FIRMWARE("intel/ibt-11-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-12-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-11-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-12-*.ddc");
> +/* hw_variant 0x11 0x12 0x13 0x14 */
> +MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
> +MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
> +MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
> +/* hw_variant 0x17 0x18 0x19 0x1b, read and use cnvi/cnvr */
> +MODULE_FIRMWARE("intel/ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].sfi");
> +MODULE_FIRMWARE("intel/ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].ddc");

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Pul

