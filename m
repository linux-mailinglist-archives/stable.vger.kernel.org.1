Return-Path: <stable+bounces-211426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAjkMYnbc2mbzAAAu9opvQ
	(envelope-from <stable+bounces-211426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 21:35:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F27A9A9
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 21:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45881301F992
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 20:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CCC2EA481;
	Fri, 23 Jan 2026 20:35:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD1B3EBF2D;
	Fri, 23 Jan 2026 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200517; cv=none; b=sLj1YPNBidbqsNZWzPjt5xhMb7KB2WwL0RDQaOBuL6NYyMsYjZKu232MHgK3fiV/7eXv+PxCXAKqnJ0riu/2VpnNvKzrRUHtvSdDJ41IPr/TO66UvXolaDLn4Db0N1fgEyO1jn1kgYqwyNZLXL40/cr+u885SxsAQWKwaal6rY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200517; c=relaxed/simple;
	bh=Jufdx5gjKnMdqzyOFkhlLU+jeTukE08/+DiozNd9DHE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tZtfJuJ1zI8avECguo3aN09QOTbeDLC5UhDLdvVzYfqwUV9raOJZYdOzN6c6kUIPAYHpSAxBnTwdzhSfcM5Ekxcfg5Tmso6G4mLKT7g5n2arZsp3NbtfJG53A47UYHZb+EmhxHQ4PFG9oLV8vS9WXPjXQsO87qPA3104OQ0NpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1D98592009C; Fri, 23 Jan 2026 21:35:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 191AC92009B;
	Fri, 23 Jan 2026 20:35:07 +0000 (GMT)
Date: Fri, 23 Jan 2026 20:35:07 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Cassel <cassel@kernel.org>
cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Frank Li <Frank.Li@nxp.com>, 
    Serge Semin <Sergey.Semin@baikalelectronics.ru>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: dwc: Fix skipped index 0 in outbound ATU
 setup
In-Reply-To: <aXKUW8euDVaRJofR@ryzen>
Message-ID: <alpine.DEB.2.21.2601232033100.6421@angie.orcam.me.uk>
References: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com> <20251229-ecam_io_fix-v2-1-41a0e56a6faa@oss.qualcomm.com> <aXI8ByG3RlLpIRRa@ryzen> <alpine.DEB.2.21.2601221806080.6421@angie.orcam.me.uk> <aXKUW8euDVaRJofR@ryzen>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,kernel.org,google.com,nxp.com,baikalelectronics.ru,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-211426-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9C0F27A9A9
X-Rspamd-Action: no action

On Thu, 22 Jan 2026, Niklas Cassel wrote:

> Please try the attached patch on top of my series.

 Thank you for the clarification and the updated patches.  I can see you 
have posted new versions since.  I'll try them sometime next week as I'm 
out of time right now.

  Maciej

