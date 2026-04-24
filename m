Return-Path: <stable+bounces-240578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIv7FjAr62keJgAAu9opvQ
	(envelope-from <stable+bounces-240578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:34:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B245B8D1
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EEAF30214FF
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D4233F8B4;
	Fri, 24 Apr 2026 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cijdMRBm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4E33B6C4
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019546; cv=none; b=gVMBsGSDm4AFxXURcEvno+CvG9g/bdaHtpgahIH1HsOh+LJduMn7H+7qo0W1dmB11V1iYJHXZpIsKbURg4GccSrEjlD9rJ3IE6GIKM3SKdXXvIrPnQCQ66YVLoJtBVWRgMUHa8P4piNgC5e/pZ+6D31ZZ5/zOArgOVA3mQzEP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019546; c=relaxed/simple;
	bh=pJkzSL/k+5TGVlKtzz3sl7/5vEzJQCMbHMekVJ4welw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLiE3N3ezePJ5MuwF+OqTSgFsr5mLA1C5AY+FUSLxZej/3nJteYXxGnE0SHlj1jGvXHSb0KRYtFx4IodIj5Htb/u3soN8rJ/srynwk9y7ksXRnCZmreJsWDg7nts/dE4b3SMIWA0spGHmnpK4odYuZKV0Obiqwq+lH9IHV3K1JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cijdMRBm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777019542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJsfL0ZYr6ksiH6VKINKLh9cflWXlJdEnCTwwmMW534=;
	b=cijdMRBmY62jxMxlWJ39bAtadDmv7b7OsxT7WwuruEvf9Cz+tt0ZDzx6CVBOwE/MYEe7/h
	TxuztRWkf7s6r/ekx5sU0h7tVnQbN74dspnNA02iNEcbBosPX67xpSysnlJ7ljdY3wgKpL
	SMjOjn6vWMF4OP5Kprkbl6UPJYoWuMM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-ewUZX9sePIKYDg19RBQe5A-1; Fri,
 24 Apr 2026 04:32:19 -0400
X-MC-Unique: ewUZX9sePIKYDg19RBQe5A-1
X-Mimecast-MFC-AGG-ID: ewUZX9sePIKYDg19RBQe5A_1777019538
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB87E1800578;
	Fri, 24 Apr 2026 08:32:17 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.44.32.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68CDB19560AB;
	Fri, 24 Apr 2026 08:32:17 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C0469A80BFD; Fri, 24 Apr 2026 10:32:14 +0200 (CEST)
Date: Fri, 24 Apr 2026 10:32:14 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@osuosl.org, stable@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	netdev@vger.kernel.org, Corinna Vinschen <vinschen@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net] iavf: iavf_virtchnl_completion:
 drop duplicate ether_addr_equal() test
Message-ID: <aesqjovwYNeLlfX4@calimero.vinschen.de>
Mail-Followup-To: Simon Horman <horms@kernel.org>,
	intel-wired-lan@osuosl.org, stable@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	netdev@vger.kernel.org
References: <IA3PR11MB898664A49E614F197D4FED6EE52C2@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260421111236.875379-1-vinschen@redhat.com>
 <20260423185530.GI900403@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423185530.GI900403@horms.kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: AF9B245B8D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240578-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,calimero.vinschen.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinschen@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]

On Apr 23 19:55, Simon Horman wrote:
> On Tue, Apr 21, 2026 at 01:12:36PM +0200, Corinna Vinschen wrote:
> > This is just a simple cleanup fix.  Commit 35a2443d0910f ("iavf: Add
> > waiting for response from PF in set mac") introduced a duplicate
> > ether_addr_equal() check, so the current code tests the new MAC twice
> > against the former MAC.
> > 
> > Remove the outer ether_addr_equal() test, remnant of commit c5c922b3e09b
> > ("iavf: fix MAC address setting for VFs when filter is rejected")
> > 
> > Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> > Fixes: 35a2443d0910f ("iavf: Add waiting for response from PF in set mac")
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > ---
> > Added CC: stable@vger.kernel.org
> 
> Hi,
> 
> This feels more like a cleanup for net-next (without a Fixes tag)
> than a fix for net. I'm missing where the bug is here.

Yeah, it's not a bug, the "Fixes" tag was just supposed to point out the
patch introducing the duplicate test.

Shall I create a v3 or is it ok as is and just goes to net-next instead
of net?


Thanks,
Corinna


