Return-Path: <stable+bounces-241487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM1wBvlo8GkITAEAu9opvQ
	(envelope-from <stable+bounces-241487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:59:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AFA47F78A
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ACCD3007B19
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 07:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD230FF1E;
	Tue, 28 Apr 2026 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RqtvEQIe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3DE302140
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363121; cv=none; b=NhZairElNzwYg9O3yntRvjtGRuuV+b/wzRD1tYL9jnx5iYjwOdLzuMbuvIvueNPbFP+1GsO/OOLXQE56VEEBE7DU3B2kgrTS/gJUcbO3bG6MkqgHf7/nO42k2yJXpRYs/kiiM8rvfjrlH+IScIUkHo+bnemgtPlFIXaSDGVuNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363121; c=relaxed/simple;
	bh=ZdxLpRAvrey223q59Wjm8MO81du/WkAqqYDf+kSiL60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unaK0sWtJJdcdCqVycdGg83EwrdSUSV0s8THLicaGm5SiAODYuN/nfxyeR1HawR5ZNZ8b3rD87JCljDTr7e+sAJvHpaXldHSXPolN6HKfAHXNWRUJUTzwmG9b6pvpJVwc0uMnWdjB7116t3UF+dtaptGTU/RQ3dhjTvJbBHiJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RqtvEQIe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cfbd17589so8678471f8f.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777363118; x=1777967918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qagrd0tizvJjaLYUYS0sYCos+nfO9AiOSWAVzoIEd+Y=;
        b=RqtvEQIeHwu1UHw50y9bGDvymuf5R3u+zf08I7L3/T4BxB7L4vdox8hImx/vGEAbVx
         9pXk7WtZFSLEEBClhansU+n8kfP/H1pViMZ8n0k/maPszR6REmpcqjcPH7nQ/MjR88hX
         lpaQ9wNfi6yLxWrm1Yt6dFS9OToghrux8ILsYepTeRZqU4g2W69PwjV58MqXSWr0ZeNk
         +jbTGL2CDIrtV/pyVeyUPxMkMGoB5QCLrUYjquMQt2j6bboEqWzCIF8nG2EVaU6FsVy2
         1qtpzMS73pA+rGTiil5N1HRGy8l+7ho4NUtAP515rvZgGFyjkI0y5G9AJ1YczPVl8q+G
         BnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777363118; x=1777967918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qagrd0tizvJjaLYUYS0sYCos+nfO9AiOSWAVzoIEd+Y=;
        b=I+LnERIoY+PvbW5FGjzijf620pa55xJjqLhFTlvhIQ6kgnKzodkqOmjcyes+/NN2XZ
         XIHo7OY9W26HChavmjeGuxEpikSWeuqP03Z/t8hG8nwCyyTR+x8U+MEk41EUI3b1CquE
         l/K7vuLebKTP/Xs3LrvPoutASK1+RtUqwsqqlwEADcwwgRjbb3GnsFIcjfR24m002HKc
         fDEdvgv7I15VgBgeDyU4Ra7Lt5w7wCf9+EfqBMoxOFl9Qhk/h2SiidjpbwUDhJGFxQ2A
         lpKIW0bCM+Y0NMFw8XRyuO8EhPNfIPnNSitnRfT4GZNGDXW24qn/qzlYzLgGa0ThPC5m
         FeRw==
X-Forwarded-Encrypted: i=1; AFNElJ/cq9ECx3xevdxSAefAnw0ae6UDvLZ2pIeRnnPXYGdc4CTWMLOiv6LqWq5FnXJEZ7Lp1Xt7Trw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkgz1i6Pus1ZIJxHZRgF0XFjt0JkDWgGZDs0fNhFbXcdBeIRIp
	+IbohhUfWQGi0tliuZw/JzeSRPOTvQmh7Mzh5d0dJtA/NhBOYSXprSS65PJMDWGe2fQ=
X-Gm-Gg: AeBDieshPxL8NpCmtezc6wcYGmy/QiRN0oWOB/9OcvHndkYl6KS+I5e7INAEtpc4GkS
	GqdZRj+Nu/AtoCTPmPF/mZI1rInLVZrnZWqubqOSJAgPSs/awcYQS3x0NtpSsCPXleuLMzKWFOA
	fGypJBPPj7pXYKglaJSm10TFiG7nydpYnRjjD9IJgS962qS3A8eIm4zFMggHpMjE5KKC3bjMB+f
	pCLukqp6KoV79PkbUFHkRKtOhqQxHC6NsAtb42FeXzx2UGAE8yD6VSfai+fjWoRLN7yZBE6B/za
	RPg92FtppYv0EPumyTCeWgb3k4vdCMWOjAAiSAt8FBrAvoSn6MSh6332NjXukt7X+g5XDo5AVbr
	xzRCfTpHioswz0c5B6dnqYNrpw/8s71AhgRvPXnYoMqmdqGa/P1ODrRc0j627IDcjQbp0SF0adM
	4YrAfBQcXk/ASFmss/OfOMH547U1PFYVdPSbVrkeGEWz+x0druC/3Z9wCISuc=
X-Received: by 2002:a05:6000:2212:b0:43f:e413:43ae with SMTP id ffacd0b85a97d-446448b900emr3496914f8f.0.1777363117896;
        Tue, 28 Apr 2026 00:58:37 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463f5b50c1sm4186489f8f.17.2026.04.28.00.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:58:37 -0700 (PDT)
Date: Tue, 28 Apr 2026 09:58:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Xie Maoyi <maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH] cgroup/cpuset: Creating or adding CPUs to partition not
 allowed without privilege
Message-ID: <7so4b76wg2apwwk3yh76q42jgwnpvlv7sursmsmzeyefhp4pbt@thybpp4litm6>
References: <20260428033439.783246-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v7j7lm3upsqvk6fp"
Content-Disposition: inline
In-Reply-To: <20260428033439.783246-1-longman@redhat.com>
X-Rspamd-Queue-Id: 18AFA47F78A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241487-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


--v7j7lm3upsqvk6fp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/cpuset: Creating or adding CPUs to partition not
 allowed without privilege
MIME-Version: 1.0

Hi Waiman.

On Mon, Apr 27, 2026 at 11:34:39PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Creation of a cpuset partition or adding more CPUs to an existing
> partition will take CPUs away from other cpusets outside of the
> partition leaving less CPUs for the others. So it is a privileged
> operation that non-privileged users shouldn't be allowed to do.
>=20
> Currently, remote partition code has check for CAP_SYS_ADMIN capability
> before allowing such operations, but not for local partition.

Remote partitions need such a check because their CPUs are sourced from
the global supply (top level) without=20

> This leaves a security hole in case cpuset.cpus.partition of a cpuset
> is chown'ed to a non-root user and its parent cpuset happens to be a
> partition root.

I wouldn't say this difference between remote and local partitions is a
security hole [1].

Consider this -- cgroup a is created by root (admin) and its resources
are constrained by root's policy. However, what happens in a subtree is
irrelevant from that top level view.

# setup			// owner
a/cpuset.partition=3Droot	// root
a/cpuset.cpus=3D0-3	// root
a/cgroup.procs		// user, they can organize subtree as needed

For example the user may want to create a (sub)partition with some of
the CPUs they got:

user$ mkdir a/b

a/b/cpuset.partition=3Droot	// user
a/b/cpuset.cpus=3D0-1		// user

This should be a valid configuration and behavior, no?

Thanks,
Michal


[1] And thanks to the need of cpuset.cpus.exclusive chain down the tree,
    the capability check for remote partitions may be too restrictive
    too. But I don't not plead for its removal now.

--v7j7lm3upsqvk6fp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCafBolxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjUaQD/WWAf7wbM6SpsqgVsTUGg
g0IHvtsWG+gcAF7OSxg8BaAA/3tsjCKLTBgl9yGrabUcfcBzpM3PrGtwFSexQPAC
Lj0E
=1WQo
-----END PGP SIGNATURE-----

--v7j7lm3upsqvk6fp--

