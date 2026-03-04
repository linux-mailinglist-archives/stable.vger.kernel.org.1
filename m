Return-Path: <stable+bounces-223014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA56IGLyp2lmmwAAu9opvQ
	(envelope-from <stable+bounces-223014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 09:50:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A71FCE9E
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 09:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 467AA310FECB
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 08:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3D3368A0;
	Wed,  4 Mar 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S2p4dOCs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731A39099F;
	Wed,  4 Mar 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613895; cv=none; b=C+k0J7DTKYFirTKmb6OBvJCa14HP4WtdgEqba2nmD1ti4wzGqFnZh1dw4FaKR93hoanHdOUtOsp2yMVxl5vfRtpSAPAhJAxCNxH8Bjz5OhY8HxPJRwXtiI6hm7InPIk8LErzitAUcYaCG2E0ShTfSHdeyfCDgYIOyqdQEXk4LtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613895; c=relaxed/simple;
	bh=Zr2EHvNcdNm+PqYcDTX9XHKOEwqhx78U/PTWRK/RnvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpfY5lLIZDKYcb9YFDwWQl58ByzjtyJilVbODF/D73tP1wCPMgpIjZXfHVKasIzjRI9hS8jZDLDaHHj42ywG5yWN7iM8MARopsv5otRud7vjOffjI79QurSMRMkgijqEJC1BIfxwkDCjqbYaUFFGYrONJPekTHiLHYbt8kR/O6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S2p4dOCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42EAC19425;
	Wed,  4 Mar 2026 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772613895;
	bh=Zr2EHvNcdNm+PqYcDTX9XHKOEwqhx78U/PTWRK/RnvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2p4dOCsllg880Zc8GHX+kxQPBKN+FsVnmJyS/TKRENlRFKigeXdIEyp0gRT8mx4B
	 VDBzC1vyJ3l2eTKNlD3Z058iDAUIw+VxuX5ksXi57FkurcaXRBisv3DFAtFbLAYdl0
	 zdUpbmxGtozHxXuIrGBAyBluBmqgWb7p06P8sY2E=
Date: Wed, 4 Mar 2026 09:44:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5YiY5Lyv56a5?= <liuboyu2024@iscas.ac.cn>
Cc: security@kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Reporting a Linux Kernel Vulnerability and Requesting a CVE ID
Message-ID: <2026030413-unstuck-catlike-cb15@gregkh>
References: <7002e9a4.4e95f.19cb7fe6fb7.Coremail.liuboyu2024@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7002e9a4.4e95f.19cb7fe6fb7.Coremail.liuboyu2024@iscas.ac.cn>
X-Rspamd-Queue-Id: 082A71FCE9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223014-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 04:37:11PM +0800, 刘伯禹 wrote:
> Dear Researchers,     We have discovered a potential vulnerability in
> the Linux kernel during our research. We submit the vulnerability
> information to you according to the procedure and apply for a CVE ID,
> based on the responses from MITRE and Red Hat.

Please see:
	https://www.kernel.org/doc/html/latest/process/cve.html
for how Linux assigns CVEs.

thanks,

greg k-h

