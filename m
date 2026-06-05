Return-Path: <stable+bounces-260711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t7CECDPfImqEegEAu9opvQ
	(envelope-from <stable+bounces-260711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 16:37:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C50648E44
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 16:37:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K7Yg31cP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260711-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260711-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC57430309BE
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 14:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1430D411;
	Fri,  5 Jun 2026 14:36:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE9333B6C8;
	Fri,  5 Jun 2026 14:36:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670212; cv=none; b=KA0sAVxLcobeeorss8BUpLtZIQp+056GZot5wuwky2ZjPE9YZ15WVoWDtKkFx7v6YuwCBhwNcq2NYfvDoMZ1oXzgwyypFmCWcUUnCF6eDVR6KySOWCABbcknWmPfdZVOlpIQyGKmP/qyVuNKtoLUFev7Oq9xlNcrMNzAvubwcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670212; c=relaxed/simple;
	bh=ZVNOL6IeLgZX1OrH9ogFg8js1L8hDqImDTnNxMmnQzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDl9UKjU7sqw/I+8e2kzgFllMqw7oY4xe6+t4RDlqafhjSyoQalcrEA+Sgv+5pLiZCXKFqtpugzYGPh23CVu+25I4ry+FRnup4+kwQg4ol/4RIwQx/S8gv3hBXI/oBTHjsaDKG0o1EWLkICvuUGLnwcbZMyoUj0cjyPRieOLyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7Yg31cP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19351F00898;
	Fri,  5 Jun 2026 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780670205;
	bh=i4bpqXmp47f/uGMec9t8TYNtzMw3VhVSFc3G03lSBL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K7Yg31cPVl0v+ylFNlqOdaJ9t/gI5tBp3TztlgiHZ/Xbss0MO+PAUs2KN3XnUSRmO
	 iLDGMsNch5hXnOonglYe5I4nj7yQW9ZH0XSZAXOAPlXozLYvU5arHy2RTxZ1hsQhkG
	 XwKjKWmDSGPXnu7L9a0WV/ATJ2sWyY1n79xuJCarWV4S4+jqbaWCveXIWXjRyiIN5B
	 oBwfTdj0WJDW39vdBF3el5gumYGtC/UnltkLwbxAnuwd+kzqgZgZQLlMEqJRnrso0n
	 rjHHRUNh9Y15+BSTVHV0GLs40Q4OH663DPYSXYMk+0rXiJwh9joOulclVc9BMCpKMq
	 kxZt/LUOoKRPA==
Date: Fri, 5 Jun 2026 15:36:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arjan van de Ven <arjan@linux.intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] proc: protect ptrace_may_access() with
 exec_update_lock (part 1)
Message-ID: <05811fd9-6a33-48d9-a970-281003466c80@sirena.org.uk>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2SFH8rxDrbPV7zxj"
Content-Disposition: inline
In-Reply-To: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
X-Cookie: Wanna buy a duck?
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260711-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jannh@google.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:arjan@linux.intel.com,m:ebiederm@xmission.com,m:jake@lwn.net,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sirena.org.uk:mid,sirena.org.uk:url,gitlab.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89C50648E44


--2SFH8rxDrbPV7zxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 06:35:15PM +0200, Jann Horn wrote:
> Fix the easy cases where procfs currently calls ptrace_may_access() witho=
ut
> exec_update_lock protection, where the fix is to simply add the extra lock
> or use mm_access():

>  - do_task_stat(): grab exec_update_lock
>  - proc_pid_wchan(): grab exec_update_lock
>  - proc_map_files_lookup(): use mm_access() instead of get_task_mm()
>  - proc_map_files_readdir(): use mm_access() instead of get_task_mm()
>  - proc_ns_get_link(): grab exec_update_lock
>  - proc_ns_readlink(): grab exec_update_lock

It seems that this patch is triggering a failure in the proc selftests
read test:

# selftests: proc: read
[  259.127414] ICMPv6: process `read' is using deprecated sysctl (syscall) =
net.ipv6.neigh.default.base_reachable_time - use net.ipv6.neigh.default.bas=
e_reachable_time_ms instead
[  259.158773] /proc/cgroups lists only v1 controllers, use cgroup.controll=
ers of root cgroup for v2 info
[  259.177155] sysrq: HELP : loglevel(0-9) reboot(b) crash(c) terminate-all=
-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) sak=
(k) show-backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-task=
s(n) poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s) show=
-task-states(t) unmount(u) force-fb(v) show-blocked-tasks(w) replay-kernel-=
logs(R)=20
# read: proc.h:49: xreaddir: Assertion `de || errno =3D=3D 0' failed.
# Aborted
not ok 19 selftests: proc: read # exit=3D134

Full log:

   https://lava.sirena.org.uk/scheduler/job/2835194#L12433

Everything except the assertation appears in a successful test:

   https://lava.sirena.org.uk/scheduler/job/2834737#L12287

bisect log:

# bad: [6e845bcb78c95af935094040bd4edc3c2b6dd784] Add linux-next specific f=
iles for 20260605
# good: [f9b5aeed37bc9023d700c9c8ff186f1e98692bc8] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [9582485a65eacfd7245ec7f0a9d7e2c34749d669] device property: fix fwn=
ode reference leak in fwnode_graph_get_endpoint_by_id()
# good: [a9c12b783cc711de3ac7f188bed07d529bb818af] device core: make struct=
 device_driver groups members constant arrays
# good: [34808ac8ddafc3e2c2a59e84eaab0a410e7a0fdc] regmap-i2c: fix sparse w=
arning in regmap_smbus_word_write_reg16
# good: [25025253476a64c186592d952c27f24bc3490e42] leds: Adjust documentati=
on of brightness sysfs node
# good: [a76640171b29fc91b9777a8e1bdc7e08db697275] Merge patch series "proc=
: subset=3Dpid: Relax check of mount visibility"
# good: [78d797520f6a74ed402cb98c6bf74d96b4937965] sysfs: remove trivial sy=
sfs_get_tree() wrapper
# good: [c5dffafb426f927db1630140552dc11d6f76e1a6] docs: proc: add document=
ation about mount restrictions
git bisect start '6e845bcb78c95af935094040bd4edc3c2b6dd784' 'f9b5aeed37bc90=
23d700c9c8ff186f1e98692bc8' '9582485a65eacfd7245ec7f0a9d7e2c34749d669' 'a9c=
12b783cc711de3ac7f188bed07d529bb818af' '34808ac8ddafc3e2c2a59e84eaab0a410e7=
a0fdc' '25025253476a64c186592d952c27f24bc3490e42' 'a76640171b29fc91b9777a8e=
1bdc7e08db697275' '78d797520f6a74ed402cb98c6bf74d96b4937965' 'c5dffafb426f9=
27db1630140552dc11d6f76e1a6'
# test job: [9582485a65eacfd7245ec7f0a9d7e2c34749d669] https://lava.sirena.=
org.uk/scheduler/job/2804101
# test job: [a9c12b783cc711de3ac7f188bed07d529bb818af] https://lava.sirena.=
org.uk/scheduler/job/2803377
# test job: [34808ac8ddafc3e2c2a59e84eaab0a410e7a0fdc] https://lava.sirena.=
org.uk/scheduler/job/2783496
# test job: [25025253476a64c186592d952c27f24bc3490e42] https://lava.sirena.=
org.uk/scheduler/job/2803433
# test job: [a76640171b29fc91b9777a8e1bdc7e08db697275] https://lava.sirena.=
org.uk/scheduler/job/2827647
# test job: [78d797520f6a74ed402cb98c6bf74d96b4937965] https://lava.sirena.=
org.uk/scheduler/job/2827487
# test job: [c5dffafb426f927db1630140552dc11d6f76e1a6] https://lava.sirena.=
org.uk/scheduler/job/2827551
# test job: [6e845bcb78c95af935094040bd4edc3c2b6dd784] https://lava.sirena.=
org.uk/scheduler/job/2835194
# bad: [6e845bcb78c95af935094040bd4edc3c2b6dd784] Add linux-next specific f=
iles for 20260605
git bisect bad 6e845bcb78c95af935094040bd4edc3c2b6dd784
# test job: [0ec6945730e17fb8a44283114493b1a54caabf09] https://lava.sirena.=
org.uk/scheduler/job/2827595
# bad: [0ec6945730e17fb8a44283114493b1a54caabf09] proc: protect ptrace_may_=
access() with exec_update_lock (part 1)
git bisect bad 0ec6945730e17fb8a44283114493b1a54caabf09
# first bad commit: [0ec6945730e17fb8a44283114493b1a54caabf09] proc: protec=
t ptrace_may_access() with exec_update_lock (part 1)
# test job: [f8823fb0641190098790d060a27b89bad4ddd73d] https://lava.sirena.=
org.uk/scheduler/job/2829222
# bad: [f8823fb0641190098790d060a27b89bad4ddd73d] proc: protect ptrace_may_=
access() with exec_update_lock (FD links)
git bisect bad f8823fb0641190098790d060a27b89bad4ddd73d
# test job: [abadd84dab07b3f9e79455b467d9ff60d12940b2] https://lava.sirena.=
org.uk/scheduler/job/2827425
# bad: [abadd84dab07b3f9e79455b467d9ff60d12940b2] Merge patch series "proc:=
 protect ptrace_may_access() with exec_update_lock"
git bisect bad abadd84dab07b3f9e79455b467d9ff60d12940b2
# test job: [f8823fb0641190098790d060a27b89bad4ddd73d] https://lava.sirena.=
org.uk/scheduler/job/2829222
# bad: [f8823fb0641190098790d060a27b89bad4ddd73d] proc: protect ptrace_may_=
access() with exec_update_lock (FD links)
git bisect bad f8823fb0641190098790d060a27b89bad4ddd73d
# test job: [0ec6945730e17fb8a44283114493b1a54caabf09] https://lava.sirena.=
org.uk/scheduler/job/2827595
# bad: [0ec6945730e17fb8a44283114493b1a54caabf09] proc: protect ptrace_may_=
access() with exec_update_lock (part 1)
git bisect bad 0ec6945730e17fb8a44283114493b1a54caabf09
# first bad commit: [0ec6945730e17fb8a44283114493b1a54caabf09] proc: protec=
t ptrace_may_access() with exec_update_lock (part 1)

--2SFH8rxDrbPV7zxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoi3vgACgkQJNaLcl1U
h9A3dQf/SC8NAl6WIr+FLRbl5GwCMDtRS/UhwS7+YPpjC0ZbPRUhanpanaRrwE9B
71fnXNe+QGBjq90Mu0ejjGt9Z8J2shzF4SMNmmqcPGA5Y14Fh7tUCS7rVEp3Z8Y0
t8HOhcNgMxveIQxNfERTC05yRUtD3+dS2UMA7QnmtaB4APvwfHqxqExt8+Se1fIR
+Zxyr6T24hqNzNOu/B1ih2AVKf2pmQ2TV3b45q/3IrRh3jnKVI9667hM7cNofYWz
n8EqdPYxMGzvQyV45vNW431XYMo0LXTS3Onm3LEQX778kdPQt6thrnT9Qh+I+psn
cyVt48uyQflFcZN/RatOXLJNkDLklA==
=qfjM
-----END PGP SIGNATURE-----

--2SFH8rxDrbPV7zxj--

