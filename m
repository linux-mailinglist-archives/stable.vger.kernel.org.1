Return-Path: <stable+bounces-254004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBpVFjrHEmoO3wYAu9opvQ
	(envelope-from <stable+bounces-254004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 11:39:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D351E5C1CD5
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 11:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D2FE300B9C1
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA303803D2;
	Sun, 24 May 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="sPTF21WD"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B934717BA2;
	Sun, 24 May 2026 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779615541; cv=none; b=QN8/AVi1rrgXi96josgE2Qve5Sg2YZbKNM7cl6pgztJE5QFp9xlRMY0P8kgwxrcNKoucMiKE2SWIYnm2pQXgCqu56DCikblPMGitNYfjyrIuDqSdOx1x2psp6cmQiRJjpAVg3BLNouSCS+luW/flp5WbztS4hvATXN5MTH4HJb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779615541; c=relaxed/simple;
	bh=R6HM1QxyEV2h/UubL9XeUIbvGYb6JOWXcKBoZvnnUes=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TbklSzLFfkxgERGsAxIT74muXZwQ+dtuY5YAZ0dwR5BAwJnoxszFvg7TffQ3VfJETez/gqZ9xEbUKun5TELH3YKtisNlj0AmkAaMEIL+bqI75VEFNMX3XDbfICyzwR3x4cRBcEOkbogMU3muUdkEdUjqhAVd9QMtW4Nmhu9VV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=sPTF21WD; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1779615536; x=1780220336; i=aros@gmx.com;
	bh=R6HM1QxyEV2h/UubL9XeUIbvGYb6JOWXcKBoZvnnUes=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sPTF21WDla8I2Z0RBMf550/ytgep5VMxBZes2jcsUPX58/SYhP9pPQ0Q/uY0eKPi
	 y2XRDmCgMIzXm3je+zLSALHXZBXgkAd1DwJLAqZdAyR8cYfnY7qx0lQ93EYQWQRS9
	 vuu16pE2ezGtxvp7QcPdhRGI4iMb3GKmiOAcEKHqnM52LUh7eeUadgMLZTLSsFPa0
	 cN83VQg9aeC9dF8dCJIpnUKiBMYQ/ajXyjSu5w0+3Tk3nMRaAPnfUWaOlqwXw3F6i
	 09fWWCCmJksKhP3galx5xmNXXyscrr5Jyw5xUXwpGMyMxG5h3RcahRIb/ng/Ka06E
	 PAZpVMmmydN48Lv23Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlGq-1wvlLM2aXI-00oaXw; Sun, 24
 May 2026 11:38:56 +0200
Message-ID: <cdb0dd2f-f331-46ed-8439-1609173f083a@gmx.com>
Date: Sun, 24 May 2026 13:38:55 +0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: [RFC/PROPOSAL] Shifting the x.y.z Stable Tree to a Continuous, Signed
 Patch-Stream Model
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AJnfC5zDqS6pE1TiZ45Qn/XgEfqOihC9sUilaBmBrB35lrUdsl1
 0Sv1azDpoGrLaeFU5tqr0HLoDz3jgrd0KHLYm2d9IXP9XY6FlFGpuh+Z19C7/SmVU9DSAKI
 BsjWBo3HAMun8sB8Fv/jBU/khKcpVdnpPGXWDsyYABFAWsL/LATh15tCL5cpRPvk/8OZF3z
 RED+A2TPTjlYVS7oxr9ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3rwFiWKB/sU=;Oxq3fd5vdTemRacWO2MmfHIPuJu
 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
 W4QozEYNj5HPJDikfqO8qatdhIQ=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254004-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aros@gmx.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: D351E5C1CD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

The relentless cadence of critical vulnerability disclosures and public=20
exploits over the past month=E2=80=94including Copy Fail (CVE-2026-31431),=
 Dirty=20
Frag (CVE-2026-43284/500), Fragnesia (CVE-2026-46300), and the ptrace=20
exit race (CVE-2026-46333)=E2=80=94has highlighted a severe structural=20
bottleneck in how we package and distribute stable backports.

When fatal logic flaws or memory corruptions strike core subsystems, our=
=20
current point-release model fractures. Spinning up whole new point=20
releases (7.0.4, 7.0.5, 7.0.7) in a matter of days just to address=20
incomplete fixes, subsystem regressions, or independent public=20
disclosures (such as the recent GRO managed-frag UAF exploit dropped=20
directly to GitHub gists by researchers) creates massive administrative=20
fatigue for maintainers and downstream teams alike.

Upstream has long maintained that the stable tree is effectively a=20
continuous stream of fixes, and that users should track the tip of the=20
stable branch rather than cherry-picking. It is time our release=20
infrastructure matches this reality.

### The Proposal

I propose transitioning the stable tree (`linux-x.y.y`) away from=20
manual,discrete point-release tarballs (`x.y.z`). Instead, we should=20
treat the stable sub-version purely as an append-only, continuous,=20
git-native patch stream.

Major releases (e.g., 7.0, 7.1) remain the foundational code boundaries,=
=20
but sub-versions are eliminated as monolithic manual artifacts.

### The Implementation: How It Works

To ensure downstream distributions, enterprise compliance engines, and=20
automated testing rings can still securely ingest code, we can replace=20
the manual tarball with a decoupled, automated asset pipeline:

1. **The Git-First Stream:** The stable branch (`linux-7.0.y`) remains=20
the single source of truth. Commits are pushed as soon as they pass=20
stable criteria and automated sanity testing.

2. **The Signed Patch-Stream Archive:** Instead of packaging the entire=20
30M+ line source code tree into a new tarball for every quick fix,=20
upstream infrastructure maintains a rolling, cumulative patch sequence=20
for the major cycle:

linux-7.0-stable.series =3D \sum (patch_1 + patch_2 + ... + patch_n)

Every time a fix is merged to the stable branch, the patch is appended=20
to a publicly accessible, cryptographically signed manifest file
(`linux-7.0-stable-patches.tar.bz2` or a standard `series` file)=20
alongside a detached signature.

3. **Automated Snapshot Tags:** If the industry strictly requires an=20
immutable archive for compliance, point-release numbers can be replaced=20
by automated, time-stamped git tags and machine-generated source=20
snapshots cut on a strict, automated interval (e.g., every 48 hours),=20
removing human maintainers entirely from the release timing.

### Why This Benefits the Ecosystem

* **Eliminates Churn and Latency:**

When a patch introduces an edge-case regression or requires an immediate=
=20
follow-up (a common reason for rapid point-release sequences),=20
maintainers do not need to coordinate a whole new release event. The=20
follow-up fix is simply patch $n+1$. Downstream CI pipelines ingest it=20
natively via standard git fetches.

* **Maintains Git-Native Debugging:**

Debugging stable regressions via `git bisect` has always been=20
patch-based, not release-based. Since point releases are meant strictly=20
for backported bug fixes, removing the arbitrary `x.y.z` release tags=20
changes nothing about a developer's ability to isolate a regression. If=20
anything, it prevents downstream vendors from pulling out-of-order=20
patches that complicate bisection across distros.

* **Eases Downstream Automation:**

Modern tracking distributions (Arch, Fedora snapshotting, etc.) can=20
switch to trunk-based intake, automatically building from the signed tip.

For enterprise distributions (RHEL, Ubuntu LTS) where constant kernel=20
packaging and reboots are untenable, a fluid patch stream allows vendor=20
security teams to more rapidly feed live-patching infrastructure=20
(`kpatch`, `kgraft`), applying critical CVE fixes directly to runtime=20
memory without changing the base package version.

* **Bridges the Compliance Gap:**

Embedded, automotive, or medical compliance pipelines
that legally require a static, verifiable code artifact can validate=20
their software against the base major release tarball ($7.0.0$) plus the=
=20
cryptographically signed, append-only stable patch series manifest.

The manual compilation, testing, and cutting of sub-version tarballs is=20
an administrative artifact of the late 1990s. Shifting to an explicit,=20
signed patch-stream architecture acknowledges the velocity of modern=20
vulnerability research, strips away artificial latency, and frees our=20
stable maintainers to focus on code quality rather than release=20
management overhead.

I would love to hear thoughts, architectural blockers, or feedback from=20
the stable maintainers and distribution teams on the feasibility of this=
=20
transition.

Best regards,
Artem S. Tashkinov

