Return-Path: <stable+bounces-163137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE27B07609
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA46F584102
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309E92F50BB;
	Wed, 16 Jul 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rl/OH9by"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8282F509B
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669912; cv=none; b=mbiJnmNP7SqmTAaHaEUub64DRwsjbv8Vxnp5OchdO8HQBOy6rJ6hNG23IItzyw4r72nIpyrZHE9zYKoMF2SEHu4kcnjb0sjDzZUJDYJPqrxZ0kW6vqGM49RJC/rkrHfSvzHA2G1jmV0jBS4cNtqBgykT9qNDyA2tBDMm7QF28qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669912; c=relaxed/simple;
	bh=bpsgmgeDGEc1PhZcHWMBFolFyeCIgQauwicXcX6/NmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HOsMyYyNCStc4RSQdj5j5s58gedWseKDi7fDiCXBE99wAFlqIE+/SYzXLJgzqetMRzYtdvHMH2JlYtmCwQ+upeW+zVbb28cntGWDHfA0TfOfwv2nCb3p0jz6pqO4Tl9NbEypEsbmv0qFn4nDkqiUF0D1kduoQPCzdHcs2R/dBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rl/OH9by; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752669906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/6quTScKxILcudF7nQxBzrgXnyLUQnBhym3m6W7b0cU=;
	b=Rl/OH9byRFjlesE6HcKql9VmK9/45cE+Mon4/mxnnou2euV8f1Znl8LnIr11m3WOmS4I2w
	ZqZzXHHXuwqtNymMc33nt9v3U/TYtGUIIiXyROUTwqL9KzL5eHvAHStqlSFZSmfnL4Plw1
	aWdcScyi4xDA7FC25km8gQ5B3xnSCv4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-cdU086dvM8ubdr7GK5D3jQ-1; Wed,
 16 Jul 2025 08:45:03 -0400
X-MC-Unique: cdU086dvM8ubdr7GK5D3jQ-1
X-Mimecast-MFC-AGG-ID: cdU086dvM8ubdr7GK5D3jQ_1752669901
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 271821800165;
	Wed, 16 Jul 2025 12:45:01 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.149])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADA491801712;
	Wed, 16 Jul 2025 12:44:57 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,  Stefano Brivio
 <sbrivio@redhat.com>,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  David Ahern <dsahern@kernel.org>,  Eric
 Dumazet <edumazet@google.com>,  Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org,  Paolo Abeni <pabeni@redhat.com>,  Charles Bordet
 <rough.rock3059@datachamp.fr>,  linux-kernel@vger.kernel.org,
  regressions@lists.linux.dev,  stable@vger.kernel.org,
  1108860@bugs.debian.org
Subject: Re: [regression] Wireguard fragmentation fails with VXLAN since
 8930424777e4 ("tunnels: Accept PACKET_HOST skb_tunnel_check_pmtu().")
 causing network timeouts
In-Reply-To: <aHYiwvElalXstQVa@debian> (Guillaume Nault's message of "Tue, 15
	Jul 2025 11:43:30 +0200")
References: <aHVhQLPJIhq-SYPM@eldamar.lan> <aHYiwvElalXstQVa@debian>
Date: Wed, 16 Jul 2025 08:44:55 -0400
Message-ID: <f7tjz485mpk.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Guillaume Nault <gnault@redhat.com> writes:

> On Mon, Jul 14, 2025 at 09:57:52PM +0200, Salvatore Bonaccorso wrote:
>> Hi,
>> 
>> Charles Bordet reported the following issue (full context in
>> https://bugs.debian.org/1108860)
>> 
>> > Dear Maintainer,
>> > 
>> > What led up to the situation?
>> > We run a production environment using Debian 12 VMs, with a network
>> > topology involving VXLAN tunnels encapsulated inside Wireguard
>> > interfaces. This setup has worked reliably for over a year, with MTU set
>> > to 1500 on all interfaces except the Wireguard interface (set to 1420).
>> > Wireguard kernel fragmentation allowed this configuration to function
>> > without issues, even though the effective path MTU is lower than 1500.
>> > 
>> > What exactly did you do (or not do) that was effective (or ineffective)?
>> > We performed a routine system upgrade, updating all packages include the
>> > kernel. After the upgrade, we observed severe network issues (timeouts,
>> > very slow HTTP/HTTPS, and apt update failures) on all VMs behind the
>> > router. SSH and small-packet traffic continued to work.
>> > 
>> > To diagnose, we:
>> > 
>> > * Restored a backup (with the previous kernel): the problem disappeared.
>> > * Repeated the upgrade, confirming the issue reappeared.
>> > * Systematically tested each kernel version from 6.1.124-1 up to
>> > 6.1.140-1. The problem first appears with kernel 6.1.135-1; all earlier
>> > versions work as expected.
>> > * Kernel version from the backports (6.12.32-1) did not resolve the
>> > problem.
>> > 
>> > What was the outcome of this action?
>> > 
>> > * With kernel 6.1.135-1 or later, network timeouts occur for
>> > large-packet protocols (HTTP, apt, etc.), while SSH and small-packet
>> > protocols work.
>> > * With kernel 6.1.133-1 or earlier, everything works as expected.
>> > 
>> > What outcome did you expect instead?
>> > We expected the network to function as before, with Wireguard handling
>> > fragmentation transparently and no application-level timeouts,
>> > regardless of the kernel version.
>> 
>> While triaging the issue we found that the commit 8930424777e4
>> ("tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu()." introduces
>> the issue and Charles confirmed that the issue was present as well in
>> 6.12.35 and 6.15.4 (other version up could potentially still be
>> affected, but we wanted to check it is not a 6.1.y specific
>> regression).
>> 
>> Reverthing the commit fixes Charles' issue.
>> 
>> Does that ring a bell?
>
> It doesn't ring a bell. Do you have more details on the setup that has
> the problem? Or, ideally, a self-contained reproducer?

+1 - I tested this patch with an OVS setup using vxlan and geneve
tunnels.  A reproducer or more details would help.

>> Regards,
>> Salvatore
>> 


