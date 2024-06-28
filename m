Return-Path: <stable+bounces-56088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E491C5A6
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 20:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299AB286C47
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 18:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB6A1CD5B1;
	Fri, 28 Jun 2024 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1WY5Ykx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763841CCCD7;
	Fri, 28 Jun 2024 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599145; cv=none; b=jtN7jMEi9HFWf2gv7QcAGw0NA31tgki55FCXmHz3YSfk8klYOR9IEdEr6akKQWqctBRX76pSxItNRn02H8i6tGFIwt7ozM3PXNATl6VLfLHN0y1aCNW/CGZNze3fnGin/iXhv3VJ/NeXi8yj8+JuCzilrSR5n2S+mmTq32j1tJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599145; c=relaxed/simple;
	bh=fw7LUEm0VJhFKEe6LsJ1RGteKkItUj3kp0zZxdlvHws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9bGXazBpTKy8PfP4nQEF7BSCAW0N9KSTVBkIwhPsGEyREXd6yUBwOP3uy0LxQ27uG7GohkIsGjMw2Qn53ekqOQeRKCNXOIVGMgeUej8gAXA29XME1DhzB8Kr757qBSoEj4kBWn/mSIjlZlL/C9hshhWRyaVfkgvhpTFtd+jyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1WY5Ykx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF43C116B1;
	Fri, 28 Jun 2024 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719599145;
	bh=fw7LUEm0VJhFKEe6LsJ1RGteKkItUj3kp0zZxdlvHws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1WY5Ykx4PkJyvKwLeBLi+IuVCeO24HXBeWIG2Ii3uKYd6PbiUhasTGJTU/5noUd1
	 RlKI8POHXo/rUwo9pLAj2mEQSJXbPbH2XeZz2iQR0fdTTk3Wnm88CXPuh1Prpn+4EC
	 ZjIerqowc0yMwcR4pmFlajIjLWZAoce0IDMqT4zoQ1dSy+rwpV6rL7txfym5f3cZzs
	 nBqCH9JJNVeX5Ef0s3yBTH6mCvoEGHDWUDuy38SE4eyCVFEnn2jh7yIx0+VA3GQeoa
	 I48FwdadTMHv+6nuK1n9lj3b2n8bgvUnvU6RuTHYwNVd+cX+k9xVRniq1tq9Hql+UV
	 Rm95PyQf5kpPw==
Date: Fri, 28 Jun 2024 20:25:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Akshat Jain <akshatzen@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] ata: libata-scsi: Fix offsets for the fixed
 format sense data
Message-ID: <Zn8AJHdybqdQwsZs@ryzen.lan>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-2-ipylypiv@google.com>
 <Zn1WUhmLglM4iais@ryzen.lan>
 <0fbf1756-5b97-44fc-9802-d481190d2bd8@suse.de>
 <Zn7bghgsMR062xbb@ryzen.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn7bghgsMR062xbb@ryzen.lan>

On Fri, Jun 28, 2024 at 05:49:22PM +0200, Niklas Cassel wrote:
> On Fri, Jun 28, 2024 at 08:47:03AM +0200, Hannes Reinecke wrote:
> > On 6/27/24 14:08, Niklas Cassel wrote:
> 
> In SAT-6 there is no mention of compliance with ANSI INCITS 431-2007 should
> ignore D_SENSE bit and unconditionally return sense data in descriptor format.
> 
> Anyway, considering that:
> 1) I'm not sure how a SAT would expose that it is compliant with ANSI INCITS
>    431-2007.
> 2) This text has been removed from SAT-6.
> 3) We currently honour the D_SENSE bit when creating the sense buffer with the
>    SK/ASC/ASCQ that we get from the device.
> 
> I think that it makes sense to honour the D_SENSE bit also when generating
> sense data for successful ATA PASS-THROUGH commands (from ATA registers).

Igor, I think you should add a new patch in your series that does:

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d5874d4b9253..5b211551ac10 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -949,11 +949,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
                                   &sense_key, &asc, &ascq);
                ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
        } else {
-               /*
-                * ATA PASS-THROUGH INFORMATION AVAILABLE
-                * Always in descriptor format sense.
-                */
-               scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
+               /* ATA PASS-THROUGH INFORMATION AVAILABLE */
+               ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
        }
 }


Feel free to copy my arguments above.

I also checked VPD page 89h (ATA Information VPD page), and there are
no bits there either to claim certain SAT version compliance.

And since this text is not in SAT-6, I can only imagine that they decided
that is was not a good idea to not always honor D_SENSE...

(It does seem simpler to just always honor it...)


Kind regards,
Niklas

