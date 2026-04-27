Return-Path: <stable+bounces-241369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAmsMKaJ72kPCgEAu9opvQ
	(envelope-from <stable+bounces-241369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:07:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A27B475FBD
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86D243083356
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C99351C3A;
	Mon, 27 Apr 2026 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjCLjp3d"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06795350D7D
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305508; cv=none; b=ArajSvmO30rJR2icVoRj//v4Tlv9NdUqc7PScJowppFCEy3ryadM+ESL04rrQyzQHJAS5oy1xRUw4a9EwZVGXJR4MBKhsgyA+fqPapP04BNqfq8fqkQ7pUP9yNGcmiVKiGra5fTb/94VgGwStrK8XZ7XRK86Jft2i72C87qXRos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305508; c=relaxed/simple;
	bh=XfBAsF6tClrrSCbk1gXcv41NveFun1CLm+OPUrnpU4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNi5vmqkTRCdR1j+kTebKvpE1OvoU3I8obNMd+CKXhKKItBPa9NnK3P1ddEM2Nebbh3whgb0ojo9ZYg8LPZ1x4UrtLdqAa3f20+f8YNA+GfgAkhHGLx1mPkYgoTHeN/rUkKYz+T8IQUZWr6ldkK0ertsHykBBv+YKNumecYLTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjCLjp3d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777305506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDuNa09IWvsLtfQxm277uKUgt69EWS0YpTX06KhV77M=;
	b=BjCLjp3dccTFwwJ+oVLBfkZ8cxUibVNUBPuWDpij0bW8r9BN7RPKlcxyc1KKOkk+FDaiID
	9AUpMFzyoQdqL6ORgk+AC0H572SCjKrZk2yBnVQ4fSDYP0wqsZNpL6sVJ2B1DpUWNTnAsn
	30HDxiCm4JycdjCKpU82O6ceIsxVUiM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-z9vv6BunNjibkGWj_hACDg-1; Mon,
 27 Apr 2026 11:58:24 -0400
X-MC-Unique: z9vv6BunNjibkGWj_hACDg-1
X-Mimecast-MFC-AGG-ID: z9vv6BunNjibkGWj_hACDg_1777305500
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 957FF1944A8E;
	Mon, 27 Apr 2026 15:58:16 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.44.48.98])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 491A719560AB;
	Mon, 27 Apr 2026 15:58:16 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C0F71A8096D; Mon, 27 Apr 2026 17:58:13 +0200 (CEST)
Date: Mon, 27 Apr 2026 17:58:13 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@osuosl.org,
	stable@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	netdev@vger.kernel.org, Corinna Vinschen <vinschen@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: iavf_virtchnl_completion:
 drop duplicate ether_addr_equal() test
Message-ID: <ae-HlZOV-VntF03O@calimero.vinschen.de>
Mail-Followup-To: Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, intel-wired-lan@osuosl.org,
	stable@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	netdev@vger.kernel.org
References: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260421111236.875379-1-vinschen@redhat.com>
 <20260423185530.GI900403@horms.kernel.org>
 <aesqjovwYNeLlfX4@calimero.vinschen.de>
 <30b2fade-2545-4f2b-98ad-c6449512c04e@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30b2fade-2545-4f2b-98ad-c6449512c04e@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 6A27B475FBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241369-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,calimero.vinschen.de:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinschen@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]

On Apr 24 17:37, Jacob Keller wrote:
> On 4/24/2026 1:32 AM, Corinna Vinschen wrote:
> > On Apr 23 19:55, Simon Horman wrote:
> >> On Tue, Apr 21, 2026 at 01:12:36PM +0200, Corinna Vinschen wrote:
> >>> This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
> >>> waiting for response from PF in set mac") introduced a duplicate
> >>> ether_addr_equal() check, so the current code tests the new MAC twice
> >>> against the former MAC.
> >>>
> >>> Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
> >>> ("iavf: fix MAC address setting for VFs when filter is rejected")
> >>>
> >>> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> >>> Fixes: 35a2443d0910f ("iavf: Add waiting for response from PF in set mac")
> >>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> >>> ---
> >>> Added CC: stable@vger.kernel.org
> >>
> >> Hi,
> >>
> >> This feels more like a cleanup for net-next (without a Fixes tag)
> >> than a fix for net. I'm missing where the bug is here.
> > 
> > Yeah, it's not a bug, the "Fixes" tag was just supposed to point out the
> > patch introducing the duplicate test.
> > 
> > Shall I create a v3 or is it ok as is and just goes to net-next instead
> > of net?
> > 
> > 
> > Thanks,
> > Corinna
> > 
> 
> I can make a note for later and either myself or Tony can forward it
> net-next as part of an Intel Wired LAN update when the merge window
> re-opens and any testing has completed. (Not that there is much needing
> to be tested in this patches case)

That's nice, thank you!


Corinna


