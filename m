Return-Path: <stable+bounces-233893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OvZFEtQ1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:55:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C1E3BC710
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B828B3011C5A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073653BBA01;
	Wed,  8 Apr 2026 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2otG66R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD542EA48F
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652936; cv=none; b=LOmcfh1OcVvadXaPwUPKCOIdn2W063yfWTfIkQa2C+mQRRUYcZMaVeoPZ9U6sHECOl5qFpuDFS6beEWnfKXcl9mKxXZuh2V5TvPiCPcVfDtCS4cd/FAZFDP2uWpIOSSTUJH37zrzWNbpzZ4Pe9TG36aaFQk8AmFBGeDqZNDVc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652936; c=relaxed/simple;
	bh=zbth1SsdLm+DayTptQtxwl1J1+j7iC7t+R1V/eHss/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Erj2GrmelGBgxEOggmd+315VBJ65txdrL/WfcSrccOGF5pVwGbP1wFQ17srwPq/aDxZEbk4+zBFXUxe21h1ZpwPOQD+WvIPqoyZ6ivk/xC5MFvyOfI6sQ44ENFMW/zw9wHy/X9Ks7iSzq3HZmzWCpqpap+GRFNJ9sKhXOYau9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L2otG66R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAA3C19421;
	Wed,  8 Apr 2026 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775652936;
	bh=zbth1SsdLm+DayTptQtxwl1J1+j7iC7t+R1V/eHss/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2otG66RH0K6fbTlQmC4H9lNmWB8yu7K48peCDEPW2bmuDM6tBDRfPpxkapBSOIsl
	 XptyD216nsI7tPT1JOQMRcZt9nqB7VaxwqL5tGKhdPbWKRveTZZ6gUAzwTEg8oD6j/
	 /tQUie/uMq5+VYEZSD8Br9yNGuIV2xmMUBEAeSyM=
Date: Wed, 8 Apr 2026 14:55:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marek Kroemeke <mkroemeke@cloudflare.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, pmladek@suse.com,
	kernel-team@cloudflare.com
Subject: Re: Missing patches from kallsyms buildid series in 6.18.y and 6.19.y
Message-ID: <2026040827-herself-negative-d45b@gregkh>
References: <zw373rzoyossoqhzvodfzilvomdi2mtljnbakm6bmhv7itwer6@4jcp4l3qvyjv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zw373rzoyossoqhzvodfzilvomdi2mtljnbakm6bmhv7itwer6@4jcp4l3qvyjv>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233893-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C0C1E3BC710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 11:38:51AM +0000, Marek Kroemeke wrote:
> Hi,
> 
> Petr Mladek's series "kallsyms: Prevent invalid access when showing
> module buildid" [1] was partially applied to the 6.18.y longterm and
> 6.19.y stable trees. Patches 3, 5, and 6 from the 7-patch series
> landed:
> 
>   acfdbb4ab291 ("module: add helper function for reading module_buildid()")
>   cd6735896d03 ("kallsyms/bpf: rename __bpf_address_lookup() to bpf_address_lookup()")
>   e8a1e7eaa19d ("kallsyms/ftrace: set module buildid in ftrace_mod_address_lookup()")
> 
> But patches 1, 2, 4, and 7 did not:
>   426295ef18c5 ("kallsyms: clean up @namebuf initialization in kallsyms_lookup_buildid()")
>   fda024fb6476 ("kallsyms: clean up modname and modbuildid initialization in kallsyms_lookup_buildid()")
>   8e81dac4cd54 ("kallsyms: cleanup code for appending the module buildid")
>   3b07086444f8 ("kallsyms: prevent module removal when printing module name and buildid")
> 
> Without the missing patches, __sprint_symbol() can use an
> uninitialized or dangling mod->build_id pointer during backtrace
> printing. We hit KASAN errors and stack protector failures due to this partial application.
> 
> 
> Could these four commits please be queued for both trees?
> [1] https://lore.kernel.org/all/20251128135920.217303-1-pmladek@suse.com/

All now queued up thanks.

greg k-h

