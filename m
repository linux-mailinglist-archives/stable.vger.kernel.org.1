Return-Path: <stable+bounces-243868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AiLJvbC+Gky0gIAu9opvQ
	(envelope-from <stable+bounces-243868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 18:01:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDDB4C1160
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 18:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D3773035263
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A73E1220;
	Mon,  4 May 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JO+cDyrs"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7273E1204
	for <stable@vger.kernel.org>; Mon,  4 May 2026 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910287; cv=none; b=c8m2UR4eo7VHxBorWiOoap/U86oGqspX0cTIccTp7WKQNjeaMjDhWRLyE8K/69ybJ9WMVTjvHARnEoTRY6eUuS5Kf6ecTGPem8SAWiYi0xA0Kvffuw8ccXN8HS2ZBkZ6oepfCJp6fn6mOdS4iFK7EhItNJ5BrRKv4ZcGQGRYbQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910287; c=relaxed/simple;
	bh=tW9EumHW1pHvUG6IQmWyvfRITKPRFwNLOdOmAnLilcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gVPKvncpyu4WDtGpykqVGAl4o8cAgKHD8GribpF9SWU+5Y2LvmLdl/T1pNNUdV750Cgwr1tv7RIG1Vk+4tqLbfkd6Gm9Ntr7DpAo5+Fvu9LLfcSmG0ociPIB7ZEpVINhJ6SSM3nR7SdfMwggroXyzgBDkdLGW35Fy7XsqWYYDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JO+cDyrs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777910284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JN8svIitjHi+0YtK7HQD4akt5dsvF1C3v1yPtgOpFGo=;
	b=JO+cDyrsZqsW112LCexz76sKCeSg+gWuy4FxDcXrc0LKaAi7AU2y4RHV2umEjnERezjGWn
	VK71WFsnxV/yLnw1pf7hx6Q1APTiBUyR2MKhmV90ul/ZMFk6acga/3eze7Rd7wOO9bZUjQ
	ShbreNKa5ZuOmJRYPZWcjR4fbmNzovI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-X9GY2M_XMLqulU50FrL-Yw-1; Mon,
 04 May 2026 11:58:01 -0400
X-MC-Unique: X9GY2M_XMLqulU50FrL-Yw-1
X-Mimecast-MFC-AGG-ID: X9GY2M_XMLqulU50FrL-Yw_1777910279
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D29751956046;
	Mon,  4 May 2026 15:57:58 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.157])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71B1530001A1;
	Mon,  4 May 2026 15:57:55 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Shuah Khan <shuah@kernel.org>,  Yuan
 Tan <tanyuan98@outlook.com>,  Yang Yang <n05ec@lzu.edu.cn>,
  dev@openvswitch.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] openvswitch: vport: fix self-deadlock on
 release of tunnel ports
In-Reply-To: <20260430233848.440994-2-i.maximets@ovn.org> (Ilya Maximets's
	message of "Fri, 1 May 2026 01:38:37 +0200")
References: <20260430233848.440994-1-i.maximets@ovn.org>
	<20260430233848.440994-2-i.maximets@ovn.org>
Date: Mon, 04 May 2026 11:57:54 -0400
Message-ID: <f7tcxzbxj3x.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 3FDDB4C1160
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243868-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Ilya Maximets <i.maximets@ovn.org> writes:

> vports are used concurrently and protected by RCU, so netdev_put()
> must happen after the RCU grace period.  So, either in an RCU call or
> after the synchronize_net().  The rtnl_delete_link() must happen under
> RTNL and so can't be executed in RCU context.  Calling synchronize_net()
> while holding RTNL is not a good idea for performance and system
> stability under load in general, so calling netdev_put() in RCU call
> is the right solution here.
>
> However,
> when the device is deleted, rtnl_unlock() will call netdev_run_todo()
> and block until all the references are gone.  In the current code this
> means that we never reach the call_rcu() and the vport is never freed
> and the reference is never released, causing a self-deadlock on device
> removal.
>
> Fix that by moving the rcu_call() before the rtnl_unlock(), so the
> scheduled RCU callback will be executed when synchronize_net() is
> called from the rtnl_unlock()->netdev_run_todo() while the RTNL itself
> is already released.
>
> Fixes: 6931d21f87bc ("openvswitch: defer tunnel netdev_put to RCU release")
> Cc: stable@vger.kernel.org
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>


