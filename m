Return-Path: <stable+bounces-235435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CsXEObO12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:08:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B40FA3CD67C
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E2CF3118401
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEFA3E1CEA;
	Thu,  9 Apr 2026 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH87QZ7N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7893DBD7C;
	Thu,  9 Apr 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749830; cv=none; b=ZqGRlPa7E2X1e7cQQRLsHieApA1wY1mihkP1Xryj6R2TJ7eJFXXjLYDkcoQS8J7mx5DnpdtTovoCASk+JHHeLRY34j71BU6RvNn1R0+L7u+MCzCU61qVr4HUtaNopTnb5Kwih8tQrbNly8MPDI4E06mR0G2WVIQLRH32HaZgcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749830; c=relaxed/simple;
	bh=rX48IB2IMYPI8ssHHUyPf1RQIH+r7jVnPzWySnEGRM4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bnwTcPqB8GZtxZ6S5ogkFFtgxwCGKLpBZg8WuAj6o66gq+BmMXQPirdStcyRkL4OHB7/4TYoeUiypY9s1ml9RIkE1Jn8iDinToEfysBmD6EJdVRRGMTAcsM5TRvGtTyAZfEMr1fPw5Oitwphvi4QaPg57Ksn/6NKatPw+0lwrKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH87QZ7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5A4C4CEF7;
	Thu,  9 Apr 2026 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749830;
	bh=rX48IB2IMYPI8ssHHUyPf1RQIH+r7jVnPzWySnEGRM4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DH87QZ7N6UcwtKUBAr0wpcBi/Xu6vuM5dbUfRNcjafYFQqaDtqjkrtzOmPBK9Ob44
	 Lexi64L8VLvmpCrkwglBxgdxKh8/iu8Jc9oWrDrlVruud9M8R3J7uPNIw5D9q0gEmZ
	 IVW1BNeMDwWcW1eOvr+1d3jwpAgMYXHa+ZXiQqE073o88VmlpFA8B01v31gbgLWViY
	 YlWsIoieOfv2bMem+D8QdUwgj2lkFuWfniXCmPMISa362NEFHd+lIBOIp6ZrNOEYhQ
	 QeTH+xu49d9IlyfubVOrBepMdSHwnN9G56W3USD89L7nJk9oBSf75UnU6Sleio9MyZ
	 9hhCpc0BXUYvA==
Date: Thu, 9 Apr 2026 17:50:27 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
cc: michael.zaidman@gmail.com, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: ft260: validate report size and payload length
 in raw_event
In-Reply-To: <20260324201858.46591-1-sebasjosue84@gmail.com>
Message-ID: <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet>
References: <20260324173527.11321-1-sebasjosue84@gmail.com> <20260324201858.46591-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235435-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xreary.bet:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B40FA3CD67C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026, Sebastian Josue Alba Vives wrote:

> ft260_raw_event() casts the raw data buffer to a
> ft260_i2c_input_report struct and accesses its fields without
> validating the size parameter. Since __hid_input_report() invokes
> the driver's raw_event callback before hid_report_raw_event()
> performs its own report-size validation, a device sending a
> truncated HID report can cause out-of-bounds heap reads.
> 
> Additionally, even with a full-sized report, a corrupted
> xfer->length field can cause memcpy to read beyond the report
> buffer. The existing check only validates against the destination
> buffer size, not the source data available in the report.
> 
> Add two checks: reject reports shorter than FT260_REPORT_MAX_LENGTH,
> and verify that xfer->length does not exceed the actual data
> available in the report. Log warnings to aid debugging.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> ---
>  drivers/hid/hid-ft260.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 333341e80..68008a423 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -1068,6 +1068,17 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
>  	struct ft260_device *dev = hid_get_drvdata(hdev);
>  	struct ft260_i2c_input_report *xfer = (void *)data;
>  
> +	if (size < FT260_REPORT_MAX_LENGTH) {
> +		hid_warn(hdev, "short report: %d\n", size);
> +		return 0;

Michael, can you please confirm whether the device can never legitimately 
send shorter than FT260_REPORT_MAX_LENGTH reports?

Thanks,

-- 
Jiri Kosina
SUSE Labs


