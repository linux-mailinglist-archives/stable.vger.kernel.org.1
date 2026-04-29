Return-Path: <stable+bounces-241951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDq0DB978mlCrwEAu9opvQ
	(envelope-from <stable+bounces-241951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:41:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E734349AAB1
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A7A5301E9A9
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CA63B388D;
	Wed, 29 Apr 2026 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNz85NnZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F423AA1BD;
	Wed, 29 Apr 2026 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498902; cv=none; b=S5tUqYbUReb/WoTJiQPrNAu6VoJKDJkhGxikT/v89pQpyy+w2m9tD1Qh3O4fQyu41rMJ6mDHOwbCvTxeVkztpTzSofqwtE35VS55w+rU/ZJ0u8KUZPIRdJM/b/eNTgwUwLtVGRygz/9eXK4VBvluMJdzV2I7LeCS+xpPKlCRovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498902; c=relaxed/simple;
	bh=ui1rqtgLpeGn5C+ZcFXl/6vBB8zvioe6IQ0674oNrzs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=a96K2gTqda8aE2s0HBKA4b9aqu/5BlndD9l4cvFOSy0S6VS4H16AwEXI6FjevWIiaNxvQJ0m8Pz8C6IcKjdEC0fCnxTQElP7eylkSFgvZX4xWrH2iPF788ECwRCY9pXfGjYtQF3b3CoA9k/kVhsJqNwNBSBpuIfF5bBJTYqCbDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNz85NnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AB1C19425;
	Wed, 29 Apr 2026 21:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777498902;
	bh=ui1rqtgLpeGn5C+ZcFXl/6vBB8zvioe6IQ0674oNrzs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=CNz85NnZ5JtP76f0yGy2+EmSGdo+mqxKdWl5iDjoNq0hFIGD/UdxytniPBUaaYurz
	 qhayyg32cyz6R9f7xxyI7OK+0PAUPP6VMcQvnaNj9Eta8XVSl+Cy8aHnJvUMH9d2nV
	 H7t91usWG6HkbWKcUkgBVjfzJZ9ujSVxaYPv5P6h8kS9rZhPpNvnryBXLNr7qR4i9D
	 F3gjgfqy6SCpCsF6mXWfhsegCTDasmvy5ZxY9ADHr0UY3ZWvE70yOgo4/+aYZoq7xK
	 YCTJEU2FekcjLBRcE+auBVr7aqgjGwY0HqrDIIm/dS6rRdqkCHjrW6H0VwFxfSk18k
	 KfBI3ICN9o/PA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 23:41:38 +0200
Message-Id: <DI5YRSXD3NAC.27M8UD3I3VY3M@kernel.org>
Subject: Re: [PATCH] drivers: base: Set mod->async_probe_requested if needed
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez"
 <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Igor Pylypiv" <ipylypiv@google.com>,
 "Chung-Kai Mei" <chungkai@google.com>, "Luis R. Rodriguez"
 <mcgrof@suse.com>, <stable@vger.kernel.org>
To: "Bart Van Assche" <bvanassche@acm.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260407160511.56289-1-bvanassche@acm.org>
 <DI4ZX1HOWDNH.3G36YTI0MYC76@kernel.org>
 <2fc4a2af-a4bb-4797-87eb-e95b835aa673@acm.org>
In-Reply-To: <2fc4a2af-a4bb-4797-87eb-e95b835aa673@acm.org>
X-Rspamd-Queue-Id: E734349AAB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241951-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

(Cc: Luis)

On Tue Apr 28, 2026 at 9:39 PM CEST, Bart Van Assche wrote:
> On 4/28/26 11:22 AM, Danilo Krummrich wrote:
>> What if userspace did explicitly pass async_probe=3D0?
>
> Does this mean that what the user has configured should take precedence,
> as in the untested patch below?

Yes, but my concern actually goes beyond that (sorry for not expressing thi=
s
properly right away).

I think the whole reason the async_probe module parameter exists in the fir=
st
place is because userspace may rely on the devices being handled by the mod=
ule
to be available directly after returning from the syscall.

Even worse, with this patch we would make this user facing behavior depende=
nt on
an implementation detail of the driver, i.e. whether it chooses to opt into
PROBE_PREFER_ASYNCHRONOUS.

