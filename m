Return-Path: <stable+bounces-249079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GJ9EavDCWrZogQAu9opvQ
	(envelope-from <stable+bounces-249079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:33:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D631456136C
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B358300F966
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C43B38BA;
	Sun, 17 May 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHvtmNMU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407836F42B;
	Sun, 17 May 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779024794; cv=none; b=i/MarQ+bsR7kCXZ7svlOTrJeJwLKFnPhNuszcsb4RkT2kJ9mf+f4dS0q/Yzn7G1WeYgVBDJzFbG07YkhLA9p6WDDk3TuZmBNNALNZR6AFbttJLSB1n36oSC2P/zl2S44DZxxwEueUqgu4NhlxRPowudqjxtRsMUQIahGGgS5Mgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779024794; c=relaxed/simple;
	bh=Dd+qYRnIsFVdUKIkcEzgoiP5rrSOKiJtuqruDAo7iS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5ZpCf6LQoRufyszl0q6dWeoNiRsTxO3z/DqhawfphRwfdqo4pa2YDoWfgjj1n9pAQoA8YfnWQoIgOJVYJPzkvtTAWTeF6vgRsbdu015MNa1UYOHZag92l5MfZ8wXrvpl6QNq8hkgcITLQ/mhBfCxMYvcBMYEKy9I0h069Tid9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHvtmNMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6242C2BCB0;
	Sun, 17 May 2026 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779024794;
	bh=Dd+qYRnIsFVdUKIkcEzgoiP5rrSOKiJtuqruDAo7iS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHvtmNMUlzUvv95sbzZ2JkAenI5CFINoHFwJ0xKuf6QUHlOr9psl5q9Q3XEuc0M2X
	 xUTcMXPTl6r8QPN/7UmfD98EuI89lqxuWsMxy9lL+rnZCNapP8m2h81rI/w2fSkjgo
	 BUqZ1+mJh31TCenMHYxduOsPulSRGtmeuueWYelnh9JlM9nXtemDK4FfOs81H7M9sf
	 mv9e4O1NwNe3zZ2TmxPpoabwn1ruuTCy9KNpJFW6plwcPj0qFRNbjtgUAYxysnn36h
	 OgjBkzph47iKz0gTlLZToNL0lZHjRll68EqC6oF9Oy+ywIAh0mWFC43lxcOkP83Lmy
	 jdiy50WZUex1Q==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	AVKrasnov@sberdevices.ru,
	edumazet@google.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	kuba@kernel.org,
	leonardi@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been added to the 6.6-stable tree
Date: Sun, 17 May 2026 09:33:06 -0400
Message-ID: <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515114521-mutt-send-email-mst@kernel.org>
References: <2026051553-santa-unretired-a417@gregkh> <20260515113503-mutt-send-email-mst@kernel.org> <2026051526-banish-strife-6dba@gregkh> <20260515114521-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D631456136C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249079-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> > What's the status of that fix?
>
> Stefano posted v3 and is working on v4.
>
> >  Should it be reverted elsewhere?
>
> Donnu. With the change we have no DoS but the socket gets silently
> broken.  Eric felt given the brokenness is upstream already it's better
> to work on a fix on top, not revert.

Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
follow-up once it lands upstream.

Thanks.

--
Thanks,
Sasha

