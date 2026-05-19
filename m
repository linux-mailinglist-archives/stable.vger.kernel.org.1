Return-Path: <stable+bounces-249644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLDxDL6WDGp1jAUAu9opvQ
	(envelope-from <stable+bounces-249644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:58:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA134582BF0
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 236F5301CFC6
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B48B40910A;
	Tue, 19 May 2026 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by40fzxP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E037409100;
	Tue, 19 May 2026 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209808; cv=none; b=IpN2R28cvPQ4oITf/sYfAOEhHa+tsEJIcDLZSwI6ilD6OgvZr5qvR7Ps0H8x0V+vOEWFBfNri9jZ51rVgl3QS55R86SMhScd9YEcQArZUdkl3x7atkfyNsGWGm43xGGYwP7acBy2WE8RftNIMvS6IaFgzxqygGXWvEaruvC+f+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209808; c=relaxed/simple;
	bh=11ckrE4HiKyRcuenxRTtM43EpwAeL4simpAQt8lARiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEN8yr/vk5A7dIb5Fq3diR/7DujAmvKOVaVbRN8PJ4b/1Gz2cnPDoBGZuDNQ5qa2EjQzx4VNVzMU3SKlQaIz5V/yN2tCYlSibhctPo1QAsHcyGUrM9udyzj+Gqa6zaCXRa4QgkBkF7DL0bfAu04sMABCoNyCG/FhMrLhfk5CB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by40fzxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A380AC2BCB3;
	Tue, 19 May 2026 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779209807;
	bh=11ckrE4HiKyRcuenxRTtM43EpwAeL4simpAQt8lARiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=by40fzxPMi+9tYYRKgfw4EgSDYjRkus8L/nz2bjIbc2wr7jDxXvQb9oMKb7P5RIXG
	 m9qCsqWriEqXaVOYLIXsoHEkiVCQNMSOwcHgqgYeyYW4u44jFvkjySKBKjjSGO2zNt
	 jByNhknh7MyLNujcim9/kRAiZRcQ9Mb+GIHYxrneFiTRNcB8EeMlXjPVBOM8Xx27em
	 wtDMi2WaSbaOGfaFJEtUK6qNmchu3SRXDx37DawJ85lJG4BjWh7aRTpf8tk8EKsKeb
	 CuZfHdFBwcntFeG336gGDTVD/Ok76CIkmmjcxTr8nFXo0IePVfrMmGVFS+i/kfK1EX
	 f1tgBX2kgiCtw==
Date: Tue, 19 May 2026 17:56:44 +0100
From: Simon Horman <horms@kernel.org>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix VF interrupts cleanup
Message-ID: <20260519165644.GI98116@horms.kernel.org>
References: <20260514163555.8243-1-dawid.osuchowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514163555.8243-1-dawid.osuchowski@linux.intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249644-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: EA134582BF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 14, 2026 at 06:35:55PM +0200, Dawid Osuchowski wrote:
> When a virtual function sends an IRQ map command, the PF will set up
> interrupts according to that request. However, because these interrupts are
> never reset, the next time Virtual Function initializes, the interrupts are
> still enabled for a given VF, which leads to performance degradation in
> certain cases (e.g. Data Plane Development Kit) due to interrupts being
> unexpectedly enabled and thus causing interrupt floods.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1071a8358a28 ("ice: Implement virtchnl commands for AVF support")
> Suggested-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


