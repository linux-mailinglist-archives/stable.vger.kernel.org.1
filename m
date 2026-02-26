Return-Path: <stable+bounces-219822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mICIGDpdoGm3igQAu9opvQ
	(envelope-from <stable+bounces-219822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:48:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B43011A7DB3
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEA4C30BF962
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860182D8793;
	Thu, 26 Feb 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EtvIraFx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED93B8D79;
	Thu, 26 Feb 2026 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116351; cv=none; b=Ytofw06RNWRNB0mOhpnBIVaUTtmK7wmOGgt8VMo25m8QNbluJxRrUs+/zDaRZSu8EyBctgQ2kIs4Okm/1qyTle/OivoGsPBvJN+lrukq/V772O6cGumxNXXrKsHKg0e63uKDWlKRXB9m7E+oV3EC9eio9os1vp4TAWL5Gx5J7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116351; c=relaxed/simple;
	bh=KOFO+ajaz4dNhcMye6xiJ8aQEJf+EfzFL+ek06M1pgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNc5rMxu00MyYAB5s/p+jOEHYfz/wls9FmjjwKjKWSvgz5T9HrCihwwv8HvhkGaFrGF28BOyOuHjJaqJf1OHe/bBOk+m1E2o3I3LW+CJ4DtIqNRkAtX9CfGuOr2wbbKdxZSJolQjIX+FnMx59CNI3T17THiBvicLDLkDzGHExhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EtvIraFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3186C116C6;
	Thu, 26 Feb 2026 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772116351;
	bh=KOFO+ajaz4dNhcMye6xiJ8aQEJf+EfzFL+ek06M1pgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtvIraFxA1I/s5XWR3X5jfzdLk5AzmuzKyuXGTis6SKo6XFG1qhT9LVuNwOH/cWrG
	 w1pCzG5t0NYPpDFkwNOLF8XwpdTbof2zlUIdDyoEK/IDAcyH1f+VjpNUdbB3as+ypN
	 BP+12ZZOgGaXB7mLwR+XTdUVMDQledlIneOnZAvI=
Date: Thu, 26 Feb 2026 06:32:22 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] uio: uio_pci_generic_sva: fix double free of
 devm_kzalloc() memory
Message-ID: <2026022659-carry-raisin-05ff@gregkh>
References: <20260226011632.4186353-1-lgs201920130244@gmail.com>
 <2026022555-improper-fanatic-cd10@gregkh>
 <CANUHTR8hzrnM6s_ysGea3kO8crbeq_onzgcfDTV6UAMB9QFogA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANUHTR8hzrnM6s_ysGea3kO8crbeq_onzgcfDTV6UAMB9QFogA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219822-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B43011A7DB3
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:14:54PM +0800, Guangshuo Li wrote:
> Hi Greg,
> 
> Thanks for the reminder.
> 
> This was found by a static analysis tool I designed. After a manual
> review, I confirmed the issue and sent the fix.
> 
> Would you prefer that I include the “how it was found and tested”
> information in the commit message?

As per our documentation (please go read it again), it is required :)

thanks,

greg k-h

