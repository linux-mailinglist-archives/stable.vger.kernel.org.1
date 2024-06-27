Return-Path: <stable+bounces-55904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67547919D1A
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 04:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F31A28307F
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 02:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F8E522A;
	Thu, 27 Jun 2024 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNUug9dI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE877AD23;
	Thu, 27 Jun 2024 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453746; cv=none; b=dqrQAETnfB61LyakTGjxmF+GFdl/K7MMzFRvDI0R4cH17Vn4nb1DT+T/c4GpFiGKzBJqm38wZRTM34h2KixD/RFyIurWhUianz/HPLWob276a5V20diLKrsJm4FL7E2oTBctbtiBFh5ivF6ZGFFFVH6tbRoQ+w7om/hgo4cAAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453746; c=relaxed/simple;
	bh=lr/FjHo2def6xaQB+pb3iG3zz7JJzbC56u/HeQFUeXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euMaT+rZbOqiJIH2H5WXO0xeq5bM4UCKHvSq1KfWyV/jn/kv+CDXi91Axb/8iPCorJ0I7XYCFblKQoMDXavj7gh9mh6d7Bs1flCIwcl9l7D3iV4BLoTpPpUdAVQmzvm/Vt7eTriTnTcbyJ4qX8VkN5hPI2Wuh9CMl97m7wws0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNUug9dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F931C116B1;
	Thu, 27 Jun 2024 02:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719453745;
	bh=lr/FjHo2def6xaQB+pb3iG3zz7JJzbC56u/HeQFUeXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VNUug9dIkIp/IUyfPz5EG+RlodTI6I4NyuqHc6dqy5eUiR/z4UEAmBSnz7Zw0VH0h
	 I5i3cqUEowYzx3tiJeRCMJ3a3aQvtk2jEaFCChAJMTQMHZY+pIdgjcAE/R9rly1uks
	 FKj53H2bHW7mCMIiCNFh0FOVWYG46w/uJSMRAugcUST7ou384Fd9I0UkmxievmL/KS
	 xabbtNixziW++aMiaEGCs+yWF7AfKTo4BG5V3GaZlmXoH0hq3wpcO38vlQ0bnQ0vKo
	 t5Ik+PflMp4JIBoKRoB46X+EgxO4o9eaRcrTPmnsCIqP0nRd5p61YGBrZafK8110Oj
	 v9sq1QgNjRyEg==
Message-ID: <ab75136a-cdf5-4eb1-a09a-bc59beb6b8df@kernel.org>
Date: Thu, 27 Jun 2024 11:02:23 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5.10/5.15] ata: libata-scsi: check cdb length for
 VARIABLE_LENGTH_CMD commands
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pavel Koshutin <koshutin.pavel@yandex.ru>,
 lvc-project@linuxtesting.org
References: <20240626211358.148625-1-mish.uxin2012@yandex.ru>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240626211358.148625-1-mish.uxin2012@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/24 06:13, Mikhail Ukhin wrote:
> Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
> ata_scsi_pass_thru.
> 
> The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
> cmd field from struct scsi_request") upstream.
> Backporting this commit would require significant changes to the code so
> it is bettter to use a simple fix for that particular error.

This sentence is not needed in the commit message. That is a discussion to have
when applying (or not) the patch.

> 
> The problem is that the length of the received SCSI command is not
> validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
> reading if the user sends a request with SCSI command of length less than
> 32.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
> Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
> Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>

Please send patches for libata to the ata maintainers (Niklas and myself).
Use scripts/get_maintainer.pl And you will get our addresses and see that there
is no need to spam Jens with libata patches.

> ---
>  v2: The new addresses were added and the text was updated.
>  v3: Checking has been moved to the function ata_scsi_var_len_cdb_xlat at
>  the request of Damien Le Moal.
>  v4: Extra opcode check removed.
>  drivers/ata/libata-scsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index dfa090ccd21c..38488bd813d1 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3948,7 +3948,11 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
>  	struct scsi_cmnd *scmd = qc->scsicmd;
>  	const u8 *cdb = scmd->cmnd;
>  	const u16 sa = get_unaligned_be16(&cdb[8]);
> 
> +	if (scmd->cmd_len < 32)

Given that the only service action supported is ATA_32, this check should be

	if (scmd->cmd_len != 32

> +		return 1;
> +
>  	/*
>  	 * if service action represents a ata pass-thru(32) command,
>  	 * then pass it to ata_scsi_pass_thru handler.
> --
> 2.25.1
> 

-- 
Damien Le Moal
Western Digital Research


