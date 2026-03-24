Return-Path: <stable+bounces-230069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCzRKOBCwmmCagQAu9opvQ
	(envelope-from <stable+bounces-230069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:53:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A6304321
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F82D30D6B3D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379413254A5;
	Tue, 24 Mar 2026 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h3HnpTDl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28133D6EE;
	Tue, 24 Mar 2026 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338266; cv=none; b=PQIiWV2J50ndhBu+BTQw5fB8kWw+ocQXND1mrhjHcSmye7q3HO6NrFtpABliN+XhJmt8DxSzMYZ1ESAANrlZwb9mFqjwb1z5NI74scv/+6b0OAc6OXZlsh3g2QZXy+aVEiR+MAv5gSHjGyHF0FUIxNgtx3XfzPcpz68xoDUCDAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338266; c=relaxed/simple;
	bh=/TQqw6nRnkksLRRDEo5M/JPqteyg0CJ1nEhikmhwsdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EISnAbkaEfJtVUeeAUDltG1VzPqQjeg9zzwbmyWc5Ue85V2dqDvZBE3cTNjnY9GVWF+0pAc9r8XAKSjSB5b6l4ftYaBGt9AeJzNJ5XmknlkrvrpFbu49hjVcxXh2IQuSAb0SEH/skGGJuYRxdQaaviZLOrPscy1ZMa/5teQ/EhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h3HnpTDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6544C19424;
	Tue, 24 Mar 2026 07:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774338266;
	bh=/TQqw6nRnkksLRRDEo5M/JPqteyg0CJ1nEhikmhwsdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3HnpTDlH4YXnva1ZGuBUtyILZjgKsMJ2pP/ruugBjB4Z0SL9Q6dQExjPVR2TB6zv
	 B1RgFECneoBR+yW+Mly2E/gv3mS0FTN473nMYkiUtjNQTEvOrxBHxopwQ6CaB2WP5b
	 BsbpEXCK/cu3pzLvdJaw6Dn7znAFW7ou6gGfAIJ8=
Date: Tue, 24 Mar 2026 08:44:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1 095/481] selftests: mptcp: join: check removing
 signal+subflow endp
Message-ID: <2026032449-drier-crisped-ed94@gregkh>
References: <20260323134525.256603107@linuxfoundation.org>
 <20260323134527.595315873@linuxfoundation.org>
 <4628c5e1-5c27-4715-ac52-c4157a45eaa8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4628c5e1-5c27-4715-ac52-c4157a45eaa8@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230069-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 038A6304321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 07:30:52PM +0100, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 23/03/2026 14:41, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> I do!
> 
> > ------------------
> > 
> > From: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > 
> > commit 1777f349ff41b62dfe27454b69c27b0bc99ffca5 upstream.
> > 
> > This validates the previous commit: endpoints with both the signal and
> > subflow flags should always be marked as used even if it was not
> > possible to create new subflows due to the MPTCP PM limits.
> > 
> > For this test, an extra endpoint is created with both the signal and the
> > subflow flags, and limits are set not to create extra subflows. In this
> > case, an ADD_ADDR is sent, but no subflows are created. Still, the local
> > endpoint is marked as used, and no warning is fired when removing the
> > endpoint, after having sent a RM_ADDR.
> > 
> > The 'Fixes' tag here below is the same as the one from the previous
> > commit: this patch here is not fixing anything wrong in the selftests,
> > but it validates the previous fix for an issue introduced by this commit
> > ID.
> > 
> > Fixes: 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > Link: https://patch.msgid.link/20260303-net-mptcp-misc-fixes-7-0-rc2-v1-5-4b5462b6f016@kernel.org
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh |   13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -2389,6 +2389,19 @@ remove_tests()
> >  		chk_rst_nr 0 0
> >  	fi
> >  
> > +	# signal+subflow with limits, remove
> > +	if reset "remove signal+subflow with limits"; then
> > +		pm_nl_set_limits $ns1 0 0
> > +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,subflow
> > +		pm_nl_set_limits $ns2 0 0
> > +		addr_nr_ns1=-1 speed=slow \
> > +			run_tests $ns1 $ns2 10.0.1.1
> 
> In this kernel version, these two lines should be replaced by:
> 
>   run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> 
> If that's easier, you can drop this patch and I can resend it with the fix.

I'll drop and wait for a new version from you, thanks!

greg k-h

