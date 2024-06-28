Return-Path: <stable+bounces-56108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA6C91C996
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 01:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9FA28546F
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 23:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1AF823DD;
	Fri, 28 Jun 2024 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ApQAzdfo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784856B7C
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719617502; cv=none; b=Ra5o2SSkxfNBZlzYTYrKyKOT07Ir/7KGTyTH3qdtx/5gzDKXcaVKqcZvZrQ3L0ueBa4F6/j41ms+UpX1nCLOstUvze+PqQ8uc68xxnjn9eI5dagjZly/PQuDWRQbr1+ROsyPWU76zMmHbGaCLXxz3mr9cAH7yOu4hnUuizjgd3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719617502; c=relaxed/simple;
	bh=mlam/RiG8OR5yyf6oFx2Nc/aLd/1oENFLdNxy7ZrQKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2r0KCHMT93dsg7vJvh93JlR+yOQpVw3WS1yBRuCCeRTHRqB1FK4IkIcQ+v9xlWvafQABmeJSaLvX59dSfpFatHeVOO7hLDtHmL984aU/4Lf174Ske4lfaE52sInCRcefVqU8I8iZbAGcg6Fnh96rnz9htPwqIBy+LcO/mFadsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ApQAzdfo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70670fb3860so874156b3a.1
        for <stable@vger.kernel.org>; Fri, 28 Jun 2024 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719617500; x=1720222300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8Hl707zCJA0xyGKMlIZWZ/UJ6SeiwxOy2TmrZ9BO2M=;
        b=ApQAzdfoUYk9c7coETU/0ehfJOU0Cq89hmD9q+M2JBjA7uwnBrA6U8nbi6l2tj1yQ4
         o6H1PwTJBOzYznwiz9xK5akcPNW5rQB0kLHhxuMMYsRqHs+m+KXw1r+9pLliU2pJ3ecj
         JxKt4JlmHmCvfEu5VvPeqa9dru+/VKvUNef0ySSg+RW4t80yCG8uPFNw88XzXVFWttZc
         EPsDWUXs1B1t5IfUYIAmUUDD5k+Pxyb0n9eevZhMiqy5wlvrGLWpnktYh0xQi95uQQ+I
         cmpD6MAOhTBbqX6WYdbgdEIEXF6ZWPyAzn9vik4Wz31ZVE+XXvXLxjPV4+P3XcOYGVPd
         z25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719617500; x=1720222300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8Hl707zCJA0xyGKMlIZWZ/UJ6SeiwxOy2TmrZ9BO2M=;
        b=WH7M4+bO3Cu1K372zdUaNcIeDDBoZrBnhgECiORZDHZ3SV+n/WICNLxK4pKwx7RdNA
         e/p2HaIQfpsSfHUmPk44TjfXytdNoSxtE11JSbs+iSoZ/tMuB7IQD8y4ohMvZzxn7qW4
         ko7tGErvYO8f+7HD5T/DIxRwZruTe2b8ADHFha++NJQtarZh53vHU/5c9P6kiCd+ao8F
         sGPZSFgzAeHJpvnRtCMRIP+Zu4I6okGjjrXezvo7Ye4vyKCBkvcBKVHDxcKXmIfiietx
         ecPtiBqezuXskdfC4XD4L4SHAzSmeLqPgb/QBvXAZENkhU4zHXS2XTPaPAREfyB4EkKs
         xVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcIC87owDfTgl7n59xrUpqczvMs+OShknIU44tr+DktI/ytBh/OZT1gpkPiQOxD7ZRvyTaUFnF8ckI00Q2UwVgTHh+Soi+
X-Gm-Message-State: AOJu0Yxstg4eLXCysqPT80JlpvXnYX9bvRjNGIfJNyR8vlZ9eVjBskOC
	EEkKOG19ZA42G68gn2nM6FgNDc84neJB+hLPQtMnVLWDrNQAFZn1Ch2sOqkz6w==
X-Google-Smtp-Source: AGHT+IEkBsd2z8hCx7tf9ttBNbZoREW7xh1pgF2yJLUtO/CA0CmA0+ZhNDTXd1I+IrIyBkPOtojGLQ==
X-Received: by 2002:a05:6a20:8c16:b0:1bd:2ce9:9e41 with SMTP id adf61e73a8af0-1bd2ce9a0f3mr8987294637.46.1719617499824;
        Fri, 28 Jun 2024 16:31:39 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c6c40sm21015925ad.60.2024.06.28.16.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 16:31:38 -0700 (PDT)
Date: Fri, 28 Jun 2024 23:31:35 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
Message-ID: <Zn9H17FoDDg9hpUr@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-3-ipylypiv@google.com>
 <Zn1zsaTLE3hYbSsK@ryzen.lan>
 <Zn3ffnqsN4pVZA4m@google.com>
 <Zn8EmT1fefVzgy0F@ryzen.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8EmT1fefVzgy0F@ryzen.lan>

On Fri, Jun 28, 2024 at 08:44:41PM +0200, Niklas Cassel wrote:
> On Thu, Jun 27, 2024 at 09:54:06PM +0000, Igor Pylypiv wrote:
> > 
> > Thank you, Niklas! I agree that this code is too complicated and should be
> > simplified. I don't think we should change the code too much in this patch
> > since it is going to be backported to stable releases.
> > 
> > Would you mind sending a patch for the proposed simplifications following
> > this patch series?
> > 
> 
> I would prefer if we changed it as part of this commit to be honest.
> 
> 
> I also re-read the SAT spec, and found that it says that:
> """
> If the CK_COND bit is set to:
> a) one, then the SATL shall return a status of CHECK CONDITION upon ATA command completion,
> without interpreting the contents of the STATUS field and returning the ATA fields from the request
> completion in the sense data as specified in table 209; and
> b) zero, then the SATL shall terminate the command with CHECK CONDITION status only if an error
> occurs in processing the command. See clause 11 for a description of ATA error conditions.
> """
> 
> So it seems quite clear that if CK_COND == 1, we should set CHECK CONDITION,
> so that answers the question/uncertainty I asked/expressed in earlier emails.
> 
> 
> I think this patch (which should be applied on top of your v3 series),
> makes the code way easier to read/understand:
> 

Agree, having self-explanatory variable names makes the code much more
readable. I'll add the patch in v4.

Do you mind if I set you as the author of the patch with the corresponding
Signed-off-by tag?

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d5874d4b9253..5b211551ac10 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1659,26 +1656,27 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  {
>         struct scsi_cmnd *cmd = qc->scsicmd;
>         u8 *cdb = cmd->cmnd;
> -       int need_sense = (qc->err_mask != 0) &&
> -               !(qc->flags & ATA_QCFLAG_SENSE_VALID);
> -       int need_passthru_sense = (qc->err_mask != 0) ||
> -               (qc->flags & ATA_QCFLAG_SENSE_VALID);
> +       bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
> +       bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
> +       bool is_ck_cond_request = cdb[2] & 0x20;
> +       bool is_error = qc->err_mask != 0;
>  
>         /* For ATA pass thru (SAT) commands, generate a sense block if
>          * user mandated it or if there's an error.  Note that if we
> -        * generate because the user forced us to [CK_COND =1], a check
> +        * generate because the user forced us to [CK_COND=1], a check
>          * condition is generated and the ATA register values are returned
>          * whether the command completed successfully or not. If there
> -        * was no error, we use the following sense data:
> +        * was no error, and CK_COND=1, we use the following sense data:
>          * sk = RECOVERED ERROR
>          * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
>          */
> -       if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> -           ((cdb[2] & 0x20) || need_passthru_sense)) {
> -               if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> +       if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
> +               if (!have_sense)
>                         ata_gen_passthru_sense(qc);
>                 ata_scsi_set_passthru_sense_fields(qc);
> -       } else if (need_sense) {
> +               if (is_ck_cond_request)
> +                       set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);

SAM_STAT_CHECK_CONDITION will be set by ata_gen_passthru_sense(). Perhaps we
can move the SAM_STAT_CHECK_CONDITION setting into else if?

        if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
               if (!have_sense)
                       ata_gen_passthru_sense(qc);
               else if (is_ck_cond_request)
                       set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
               ata_scsi_set_passthru_sense_fields(qc);
        } else if (is_error && !have_sense) {


> +       } else if (is_error && !have_sense) {
>                 ata_gen_ata_sense(qc);
>         } else {
>                 /* Keep the SCSI ML and status byte, clear host byte. */

Thanks,
Igor

