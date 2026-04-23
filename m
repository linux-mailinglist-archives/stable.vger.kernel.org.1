Return-Path: <stable+bounces-240527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAteOyxr6mmhzAIAu9opvQ
	(envelope-from <stable+bounces-240527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:55:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB44563F0
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8252B3014683
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E363B0ADB;
	Thu, 23 Apr 2026 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ9yjLNh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783D3AE18F;
	Thu, 23 Apr 2026 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970534; cv=none; b=BFPePSKwm0Dr5gLxjK3oImPs/3Fgyda0dfzrxJ5mEQ/Q/AhtC5lfP3Sb6vmB96EPok4zEzSU63TmsTFog/S95hiNxKbAhYPiPf5VUaZkHuMB3Jsc56o+0jSAsnrthyAlRgE5I72aglWTcSufbFpR1KR4nSciBb30r6+E09qyndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970534; c=relaxed/simple;
	bh=4yoTlqQgbbVE28AVWHdC5lL1x5os8T5h1viP5QpkKlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVQdfrqF0XX/4lYcVPhKkqcN5u7xYBS4uxTUasYcljcfVtYs8YgO2boTaPI1yZvBVVVi7sn85g7OiE0UNmuwOiVf9L2T8j5S4gmxlKkRoWdjH+My6wpI6fdQQXAW02EKhpqPOtn0hlJeUCK+qekrv8qcykNHHTgYwXNri8IutMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ9yjLNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36726C2BCAF;
	Thu, 23 Apr 2026 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970534;
	bh=4yoTlqQgbbVE28AVWHdC5lL1x5os8T5h1viP5QpkKlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQ9yjLNhzeNgz5LnKP7c5B4CVVdkDK1FCMsDtp50OIQeKLf5otwlCPfWdgWSPycw/
	 XTvQQiA9S+ZybzC9eqC7oQzsM81L7y6MNR7n4RHDo2QaO/5k9PX7EV1EEAok+xCXA+
	 f3xysYpsbXmlJ00lhGseIfBYTZq0JzKgi7HG5BkJ5ydr9JUbYQPm6Gid/Hg6hSDHz5
	 liAN2JVUnjU+EY4FBqBhoJoIltNPHvSjLCUCMvKUosbMN6Kk79SCWlApAasPYFpayE
	 JUE8mai8Fd4DutEfbulAEx6LvAf6+32ED2XpeKNOTrex27dKq87SQDqapgCZUOuE1Y
	 Qv/sCT2faOyhQ==
Date: Thu, 23 Apr 2026 19:55:30 +0100
From: Simon Horman <horms@kernel.org>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: intel-wired-lan@osuosl.org, netdev@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] iavf: iavf_virtchnl_completion: drop duplicate
 ether_addr_equal() test
Message-ID: <20260423185530.GI900403@horms.kernel.org>
References: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260421111236.875379-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421111236.875379-1-vinschen@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240527-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 63BB44563F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 01:12:36PM +0200, Corinna Vinschen wrote:
> This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
> waiting for response from PF in set mac") introduced a duplicate
> ether_addr_equal() check, so the current code tests the new MAC twice
> against the former MAC.
> 
> Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
> ("iavf: fix MAC address setting for VFs when filter is rejected")
> 
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> Fixes: 35a2443d0910f ("iavf: Add waiting for response from PF in set mac")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> Added CC: stable@vger.kernel.org

Hi,

This feels more like a cleanup for net-next (without a Fixes tag)
than a fix for net. I'm missing where the bug is here.

