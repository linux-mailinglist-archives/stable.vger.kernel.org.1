Return-Path: <stable+bounces-245035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bJ03CwulAGo8LQEAu9opvQ
	(envelope-from <stable+bounces-245035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:32:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D1B504D9C
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFA30300A3A8
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0136AB5A;
	Sun, 10 May 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F67ppo9p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BACA4E;
	Sun, 10 May 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427141; cv=none; b=qoyEfvTges87/dAYieUkuPLZcR4zLpNaciFUWuXpNMtn29GvCA5pfeUZ7zfZQUg2nde0aB0GelR3m4bt1YmzpT21FVk6+ML1ZJSSzhd5BBepIg9Q7UMCBjPyoe5dOmqOzAXDw1hyOPK5v56pUTIL0IL7Bk5X0Xes+pGP+DXgrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427141; c=relaxed/simple;
	bh=IP9ymPdhjEvlsXziBwpZgl3VeAVkIzU9wywqT4QOBtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VceUGhGDVscxs0lwzNcj+GZpPyh3Vp6NrWoH04yOosylnjeL/GMybQWSyLxYlINHYCiVrmz9yKzaWjGniL6onqW3zQHv5Aesgj6MOl7ENaeeM9+m3g8ale+PQIZN4jYSdASE8YanReB+vJuB90/s5Izxz6ivrRZd2EswJBYvHh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F67ppo9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78E7C2BCB8;
	Sun, 10 May 2026 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778427141;
	bh=IP9ymPdhjEvlsXziBwpZgl3VeAVkIzU9wywqT4QOBtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F67ppo9pcFhYGh5QQ+R/kDruLnCYONRpYIMakk04BzmRRzyGvDRzYpvPObfZYGyPM
	 xkwrcKlLXL1U4LyEiqzK4mbmzJtOEyJV464lde8Ahl35J0Tdaj5l+SA8nvmI8TsMT4
	 PffOXiNV7C3PuVzUen0IEDHSsFXsBfZ1PpvFzt749yUo5YbCOtAYZsY8k/17/wNUOR
	 udpf1xuOV8namHBU2mcfOY5zHN87Fnm5NsAqtuU64UzDTxlFKbBpFeiPoK1tm4O4c4
	 uc9aiqEj58jkVfzLO78PXLnTwQenuFb/exRSrr8F7i3PMwaTQMt8222R5nUK1RPEVk
	 i0deBd1uPN43g==
Date: Sun, 10 May 2026 16:32:16 +0100
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	jacob.e.keller@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net] ice: restore PTP Rx timestamp config after
 ethtool  set-channels
Message-ID: <20260510153216.GU15617@horms.kernel.org>
References: <20260507081653.1717172-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507081653.1717172-1-grzegorz.nitka@intel.com>
X-Rspamd-Queue-Id: C2D1B504D9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245035-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 10:16:53AM +0200, Grzegorz Nitka wrote:
> When ethtool -L changes queue counts, ice_vsi_recfg_qs() closes and
> rebuilds the VSI, reallocating Rx rings. The newly allocated rings have
> ptp_rx cleared, so RX hardware timestamps are no longer attached to skb
> until hwtstamp configuration is applied again.
> 
> Restore timestamp mode after ice_vsi_open() in the queue reconfiguration
> path, matching reset/rebuild behavior and ensuring newly rebuilt Rx rings
> have PTP RX timestamping re-enabled.
> 
> Testing hints:
> - run ptp4l application in client synchronization mode:
> 	 ptp4l -i ethX -m -s
> - run PTP traffic
> - change queue number on ethX netdev interface:
> 	ethtool -L ethX combined new_queue_size
> - observe ptp4l output
> - expected result: no "received DELAY_REQ without timestamp" messages
> 
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Cc: stable@vger.kernel.org
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR: There is an AI-generated review of this patch available on sashiko.dev.
     I do not believe any of the issues raised there should block progress
     of this patch.

