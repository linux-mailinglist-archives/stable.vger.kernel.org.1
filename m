Return-Path: <stable+bounces-6810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 720FA8146D8
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 12:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BFF1F211A5
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E8124A15;
	Fri, 15 Dec 2023 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tr2LhUQz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431B250E2
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 11:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1835C433C7;
	Fri, 15 Dec 2023 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702639618;
	bh=fA1hGhHhAZ1Xj+eOMfobIe1sLYNAJzCGgh4X92ivN/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tr2LhUQzeR0dgamyiDGksl41wMZ+68ga/H8bs3R5M6mtIsEJ/8ReeUrWPWaGEZCiQ
	 9U59lvKcroyW8l+yVgsKPlbWYO0c3WQkWgTiMf6ptP0B2+BWkL8vTPMeE1GYOKbImx
	 Fih+6c/MDg26+qH8wNVzdFSnfFsq1YsHNJL41Hyg=
Date: Fri, 15 Dec 2023 12:26:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Hannes Reinecke <hare@suse.com>, kernel@openvz.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] scsi: code: always send batch on reset or error
 handling command
Message-ID: <2023121548-dubiously-staple-758e@gregkh>
References: <20231215103013.2879483-1-alexander.atanasov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215103013.2879483-1-alexander.atanasov@virtuozzo.com>

On Fri, Dec 15, 2023 at 12:30:13PM +0200, Alexander Atanasov wrote:
> In commit 8930a6c20791 ("scsi: core: add support for request batching")
> blk-mq last flags was mapped to SCMD_LAST and used as an indicator to
> send the batch for the drivers that implement it but the error handling
> code was not updated.
> 
> scsi_send_eh_cmnd(...) is used to send error handling commands and
> request sense. The problem is that request sense comes as a single
> command that gets into the batch queue and times out.  As result
> device goes offline after several failed resets. This was observed
> on virtio_scsi device resize operation.
> 
> [  496.316946] sd 0:0:4:0: [sdd] tag#117 scsi_eh_0: requesting sense
> [  506.786356] sd 0:0:4:0: [sdd] tag#117 scsi_send_eh_cmnd timeleft: 0
> [  506.787981] sd 0:0:4:0: [sdd] tag#117 abort
> 
> To fix this always set SCMD_LAST flag in scsi_send_eh_cmnd and
> scsi_reset_ioctl(...).
> 
> Fixes: 8930a6c20791 ("scsi: core: add support for request batching")
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/scsi/scsi_error.c | 2 ++
>  1 file changed, 2 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

