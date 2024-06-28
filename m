Return-Path: <stable+bounces-56091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6DA91C5FF
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 20:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC8DB24722
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9638E1CE090;
	Fri, 28 Jun 2024 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQJx335b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167E1CE087;
	Fri, 28 Jun 2024 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600286; cv=none; b=ZvMdQHqHKyalz80Io6rMJjF4Nj1Vi42AwZ2JhNErq8xqJrq1NlPT7QqjtuJyNBeCoT/QdQriOnsvbVF4lQdUSNhu0M6Oyn5T4usxK9ENijoAIEZ8oL08Q1hSbP3NpiIN5mnn/1acPNRZPHA7ofUbRETHL4iILCZaL9kDj9Am8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600286; c=relaxed/simple;
	bh=TojJnQL9RaBjm4QgGb02q4GOqfk8aC6iXrl2HScJwXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J991ihSYEVIkVq8yTucv6la3gibVExfPqqCLbiwjOGDo6T36jThr3GP85DXMCOJR+3/VJXNl1qFe9SuWOUaw81Wvv/Ll5Mhf0yfcJtrjigpsREdwRtFwTRn54Nl7YWOkzkIRS5pAJj6hrMhmi5MElWGBsTlbc4BQbB5nJvyGod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQJx335b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46313C116B1;
	Fri, 28 Jun 2024 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719600285;
	bh=TojJnQL9RaBjm4QgGb02q4GOqfk8aC6iXrl2HScJwXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQJx335budzDjbxiJmgE8ap98NyXQ39VbGjrPcOUYHNg57UCVY1ot/cDtE0FMqjnU
	 x+9hUpMZdwEP5LC4HnTo+yqOb1XNN8ELJtrvPo1zR44DlDpfM0T6zaozstVa3AWHGt
	 qxye3+r3kT+BmY7/4OJazOhdlDZUErsaQHktHINxmzAOlOMbmf00mC42neGxAp95bu
	 dj6kvVEblhVcJBKU+PwZdbguEMSMi/tI4J47SaoQ/Ni+vOJrZ2EaZyzjEJN+c2AOlg
	 SOYBguHOmA4wykK86YpS6y+XizW7aMrfkMCBgIYtah0vkcdnsE+gY9xVs8Na6wECsf
	 7Xrntfb4eJV5A==
Date: Fri, 28 Jun 2024 20:44:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
Message-ID: <Zn8EmT1fefVzgy0F@ryzen.lan>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-3-ipylypiv@google.com>
 <Zn1zsaTLE3hYbSsK@ryzen.lan>
 <Zn3ffnqsN4pVZA4m@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn3ffnqsN4pVZA4m@google.com>

On Thu, Jun 27, 2024 at 09:54:06PM +0000, Igor Pylypiv wrote:
> 
> Thank you, Niklas! I agree that this code is too complicated and should be
> simplified. I don't think we should change the code too much in this patch
> since it is going to be backported to stable releases.
> 
> Would you mind sending a patch for the proposed simplifications following
> this patch series?
> 

I would prefer if we changed it as part of this commit to be honest.


I also re-read the SAT spec, and found that it says that:
"""
If the CK_COND bit is set to:
a) one, then the SATL shall return a status of CHECK CONDITION upon ATA command completion,
without interpreting the contents of the STATUS field and returning the ATA fields from the request
completion in the sense data as specified in table 209; and
b) zero, then the SATL shall terminate the command with CHECK CONDITION status only if an error
occurs in processing the command. See clause 11 for a description of ATA error conditions.
"""

So it seems quite clear that if CK_COND == 1, we should set CHECK CONDITION,
so that answers the question/uncertainty I asked/expressed in earlier emails.


I think this patch (which should be applied on top of your v3 series),
makes the code way easier to read/understand:

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d5874d4b9253..5b211551ac10 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1659,26 +1656,27 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
        struct scsi_cmnd *cmd = qc->scsicmd;
        u8 *cdb = cmd->cmnd;
-       int need_sense = (qc->err_mask != 0) &&
-               !(qc->flags & ATA_QCFLAG_SENSE_VALID);
-       int need_passthru_sense = (qc->err_mask != 0) ||
-               (qc->flags & ATA_QCFLAG_SENSE_VALID);
+       bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
+       bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
+       bool is_ck_cond_request = cdb[2] & 0x20;
+       bool is_error = qc->err_mask != 0;
 
        /* For ATA pass thru (SAT) commands, generate a sense block if
         * user mandated it or if there's an error.  Note that if we
-        * generate because the user forced us to [CK_COND =1], a check
+        * generate because the user forced us to [CK_COND=1], a check
         * condition is generated and the ATA register values are returned
         * whether the command completed successfully or not. If there
-        * was no error, we use the following sense data:
+        * was no error, and CK_COND=1, we use the following sense data:
         * sk = RECOVERED ERROR
         * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
         */
-       if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
-           ((cdb[2] & 0x20) || need_passthru_sense)) {
-               if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
+       if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
+               if (!have_sense)
                        ata_gen_passthru_sense(qc);
                ata_scsi_set_passthru_sense_fields(qc);
-       } else if (need_sense) {
+               if (is_ck_cond_request)
+                       set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
+       } else if (is_error && !have_sense) {
                ata_gen_ata_sense(qc);
        } else {
                /* Keep the SCSI ML and status byte, clear host byte. */

