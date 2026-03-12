Return-Path: <stable+bounces-224805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKByO3pcsmkZMAAAu9opvQ
	(envelope-from <stable+bounces-224805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:26:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 531C026D9F9
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD68301D316
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 06:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB4D3502A4;
	Thu, 12 Mar 2026 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eIy/IUI+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E40303CA0;
	Thu, 12 Mar 2026 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296760; cv=none; b=A6Ju13bIS9tN7g/s059E52KMWOEgeM4WF6aX8z0MbP9DNa0Q1euM4YNbdjba7GPiggRrptGO+5sohM78IrpnXcy94bsLOiKFbV+1iRNLmSe+bmiuU0RiMQ6YVt5df3jq3njQTSnGSvMfCXnHivsorfvOsgsGWtw2Ub7WBZA7kAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296760; c=relaxed/simple;
	bh=us6vuoIvQAI/20Llr77KpQic2drfxzzoWJBG+BBSrAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKeUTsmY/QJMwtONuQw2ReJFfKLi7ksYW0mKY0uA/enLpoi18fr3Xw1C9oWnujzbclgbayjRs2rPPl9rThJbocmgG/FPul891kyBbIo7WmIBZO7j3ejQo69wkTIlH0RmD65dhA+dCpXdLrw8ClJQAeo78WmX6GvaCzDunyZ7TMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eIy/IUI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA15EC4CEF7;
	Thu, 12 Mar 2026 06:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773296759;
	bh=us6vuoIvQAI/20Llr77KpQic2drfxzzoWJBG+BBSrAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIy/IUI+w/EOxMlihf1gv1wI84SpsgSLHkpfz0Z36dc2ndeCSE24T/Nh2W+04TtEz
	 m5F0YOeb9nHQ37v5omIbtqmy1bEKS1xJBVJO1+hu2WNAoc+S+GgVrsGdTNCAzRcki1
	 8L7vrjD9bSCCOaTkW3zkKNmncGJMXjMJFMhwu220=
Date: Thu, 12 Mar 2026 07:25:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Rebello <nathan.c.rebello@gmail.com>
Cc: linux-usb@vger.kernel.org, heikki.krogerus@linux.intel.com,
	kyungtae.kim@dartmouth.edu, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: ucsi: validate connector number in
 ucsi_connector_change()
Message-ID: <2026031238-richly-tattle-eab8@gregkh>
References: <20260312060815.55-1-nathan.c.rebello@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312060815.55-1-nathan.c.rebello@gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224805-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 531C026D9F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 02:08:15AM -0400, Nathan Rebello wrote:
> ucsi_connector_change() uses the connector number from the CCI as an
> index into the connector array without first verifying it falls within
> the valid range. The connector number is extracted from the CCI register
> via UCSI_CCI_CONNECTOR(), which returns a 7-bit value (0-127), but the
> connector array is typically only 2-4 entries.
> 
> A malicious or malfunctioning device could report an out-of-range
> connector number, causing an out-of-bounds array access.
> 
> Add a bounds check in ucsi_connector_change() itself, before the array
> dereference, as it is the single function through which all connector
> change events flow.
> 
> Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
> ---
> v3:
>  - Added changelog (Greg's bot)
> v2:
>  - Kept bounds check in ucsi_connector_change() rather than moving it
>    to ucsi_notify_common(), as ucsi_connector_change() is the true
>    central validation point covering all callers (ucsi_notify_common,
>    ucsi_register, and backend-specific call sites) (Greg KH)
> 
>  drivers/usb/typec/ucsi/ucsi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index a7b388dc7fa0..b4f630154aba 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1345,7 +1345,14 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>   */
>  void ucsi_connector_change(struct ucsi *ucsi, u8 num)
>  {
> -	struct ucsi_connector *con = &ucsi->connector[num - 1];
> +	struct ucsi_connector *con;
> +
> +	if (num < 1 || num > ucsi->cap.num_connectors) {
> +		dev_warn(ucsi->dev, "bogus connector change event: connector %u\n", num);
> +		return;
> +	}

Shouldn't we "fail" something here?  If this device is sending broken
data, we don't want the caller to just assume this succeeded, right?

Shouldn't stuff like this be checked in a single call after read_cci()
is called?  The other calls to ucsi_connector_change() are not operating
on a "new" descriptor value from what I can tell, but I might have
missed a code path somewhere.

thanks,

greg k-h

