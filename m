Return-Path: <stable+bounces-217556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IJSOjg1mGn/CgMAu9opvQ
	(envelope-from <stable+bounces-217556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:19:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FFF166C74
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C43309C28B
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D993A33B951;
	Fri, 20 Feb 2026 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyXJGIe4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AD33B6CC
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582632; cv=none; b=DuuZOxF2pU7sah0BDv03upvWw7k4/b85Aov6Va/ysN/BUCYDAZeNvVpTJoyGUpy0koY/staZCvnN5RxYwj8YFGC2QMEiMDsSokKYhDOio4qmwbj9U4Z2q+OceggYfExCUJsM9DIWSotgfEmcHo52hWblzVxTAuwntKMq+ToZ0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582632; c=relaxed/simple;
	bh=p2k6pWtIsWSnFSLP2RBtbJq52aI2gnODo0HD/B9Bb7g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Wl4QOc/PpwrjEH+/z+Y6qRPbHVTsPE4ZTo8kxlCAF1BcvEiQ9I/ZmlU05EQVoLKwF1CNpEmBhWTI+aPRg8HfwDwEtLRB1Y6k0ooB3ks146VcPT7mlNAPOiQ8ynQAa4PEGsRlILAP9jDuJLeXoRL8OtTKZvHJQQ/nCZZM7Nx/pdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyXJGIe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA55BC116D0;
	Fri, 20 Feb 2026 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582632;
	bh=p2k6pWtIsWSnFSLP2RBtbJq52aI2gnODo0HD/B9Bb7g=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=UyXJGIe40+t97tpN8dEFOyel8KT9L8bnqZjxeRmLJcZxGelI+4DUEZCCPzHhqU3+Y
	 D5WXu3XzhN9cdfI+fZi9hx5lJP/pT39mneYuG126DBQkFcCdbMDDTPHf4gbHNeI9Wd
	 nY/h4GBHFQmO+lz0NlhqYAuYLOYctlpzcZYdAPJDZs1+BQJQ1SOVtRW5VHXj+T5vLg
	 hpTsnGKtgpQGEwWj2CoXh2SxV04ycrQwyjH21V3nnJjeOV8m+eEegml+j+0P6He0vE
	 /XepDWtQDGkIzRE55lRzIziRavXK75hyzKdXWfVwjdUrjDJI8U3pRQK0Tn8SB7uc0n
	 SI7YDWT4DodVg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Feb 2026 11:17:09 +0100
Message-Id: <DGJPMOESHINC.1NGNT8LLY8DKW@kernel.org>
Subject: Re: [PATCH v3 1/3] gpu/buddy: fix module_init() usage
Cc: "Koen Koning" <koen.koning@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Matthew Auld"
 <matthew.auld@intel.com>, "Dave Airlie" <airlied@redhat.com>, "Peter Senna
 Tschudin" <peter.senna@linux.intel.com>, <stable@vger.kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260216111902.110286-1-koen.koning@linux.intel.com>
 <20260219213858.370675-1-koen.koning@linux.intel.com>
 <20260219213858.370675-2-koen.koning@linux.intel.com>
 <2026022016-creole-limpness-6ae7@gregkh>
In-Reply-To: <2026022016-creole-limpness-6ae7@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217556-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48FFF166C74
X-Rspamd-Action: no action

On Fri Feb 20, 2026 at 7:06 AM CET, Greg KH wrote:
> On Thu, Feb 19, 2026 at 10:38:56PM +0100, Koen Koning wrote:
>> Use subsys_initcall() instead of module_init() (which compiles to
>> device_initcall() for built-ins) for buddy, so its initialization code
>> always runs before any (built-in) drivers.
>> This happened to work correctly so far due to the order of linking in
>> the Makefiles, but this should not be relied upon.
>
> Same here, Makefile order can always be relied on.

I want to point out that Koen's original patch fixed the Makefile order:

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 5cd54d06e262..b4e5e338efa2 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -2,8 +2,9 @@
 # drm/tegra depends on host1x, so if both drivers are built-in care must b=
e
 # taken to initialize them in the correct order. Link order is the only wa=
y
 # to ensure this currently.
+# Similarly, buddy must come first since it is used by other drivers.
+obj-$(CONFIG_GPU_BUDDY)	+=3D buddy.o
 obj-y			+=3D host1x/ drm/ vga/ tests/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+=3D ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)		+=3D trace/
 obj-$(CONFIG_NOVA_CORE)		+=3D nova-core/
-obj-$(CONFIG_GPU_BUDDY)		+=3D buddy.o

He was then suggested to not rely on this and rather use subsys_initcall().

When I then came across the new patch using subsys_initcall() I made it wor=
se; I
badly confused this with something else and gave a wrong advise -- sorry Ko=
en!

(Of course, since this is all within the same subsystem, without any extern=
al
ordering contraints, Makefile order is sufficient.)

