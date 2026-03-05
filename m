Return-Path: <stable+bounces-223248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MElTJKeqqWlSBwEAu9opvQ
	(envelope-from <stable+bounces-223248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:09:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C7F215267
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 17:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE25E301AFDA
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F361E39F197;
	Thu,  5 Mar 2026 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZJCCAVU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70EC37C0FE;
	Thu,  5 Mar 2026 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726045; cv=none; b=GTrYIntTZD4qnDAjsS0VvJPp2xQoQXwsu/muvbCJDaXXcuNpEqmLdR450r/AdoXO5stEw4/POKcu9y8BspqmbWsFLnt49YzGyWFpdYDViillSBefWBB+NSwKUo3dK3MsVeTg+xdh9l41STDU21Vrw/eXSTx+Vh7f3ru/DOznf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726045; c=relaxed/simple;
	bh=bidVYVICOdGRtsflGC4A0uveaK1vUY8eMwnQDgINvJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv1F0mvUCQQRzx8MO8D3daQhX36jjmJ0pQFsAHkWh093eTT0C0K+ooyAdA+1d5P5Oi6y5CGdmbTm7Q1aoxEZDL07r+96FkmM7XOGFPbribIio+pGwkQbWKvAAEFM/SatJkFKe8CByeGl5fzEjMKKoEs5Ltcdo8k2i5DUPAd4RNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZJCCAVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7B2C116C6;
	Thu,  5 Mar 2026 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772726045;
	bh=bidVYVICOdGRtsflGC4A0uveaK1vUY8eMwnQDgINvJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZJCCAVUWWYORhHM/hXKwyUzjRceofEDLc5kRET0rTP7R6iy+D0Ajm0btkk8m+WFO
	 h+fc0jfhIfLyBBpTL4+7W8xqSfn5KE1Kg2nlDIblOoWOQkrz3Pq2NJwjk4OVl/e7oO
	 gHa1vXaMgWbQJe4aqwrwoJ/LhdDAo7wYy4FY9/Rlyj29bqqcOdrtZBgW/1C7XThz76
	 lIcJJ0o+bHEEAoTJgI39/deFtUjy3KRx4kZ56b16lAY+rskU9QIXDtqoEugclap2JJ
	 IbtSMxdcIsm88dwZNkSNqjQlGc0g/U/1QflrQKmqRYFvCWTd7Qqi/ZZtTqT6jytX1D
	 zkul7kfsLNx9A==
Date: Thu, 5 Mar 2026 16:54:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
Message-ID: <aamnGNm_IHHfSVgL@ryzen>
References: <20260305145312.1081112-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305145312.1081112-1-pfalcato@suse.de>
X-Rspamd-Queue-Id: E7C7F215267
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223248-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 02:53:12PM +0000, Pedro Falcato wrote:
> Currently, whenever you boot with a QEMU drive over an AHCI interface,
> you get:
> [    1.632121] ata1.00: applying bridge limits
> 
> This happens due to the kernel not believing the given drive is SATA,
> since word 93 of IDENTIFY (ATA_ID_HW_CONFIG) is non-zero. The result is
> a pretty severe limit in max_hw_sectors_kb, which limits our IO sizes.
> 
> [...]


Added Damien's R-b tag, since the patch is essentially the same as V1.


Applied to libata/linux.git (libata-for-7.0-fixes), thanks!

[1/1] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
      https://git.kernel.org/libata/linux/c/b92b0075

Kind regards,
Niklas

