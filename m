Return-Path: <stable+bounces-238023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJkqAdoK32n3NwAAu9opvQ
	(envelope-from <stable+bounces-238023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:49:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A9D400201
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85A26301DE72
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EAD3264D9;
	Wed, 15 Apr 2026 03:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d5+5HQVI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956030EF77
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224956; cv=none; b=cYw4si4UfwJoCDr+G7q/Z7q9kXC2hLnk4FOVPt85f6yHrBL/kfAj/J7jaPYjHZhEskOJnd7kKYJyg1/oHO53nzrVjOUuB25ap7Osu5ODS4eTjFyNTBFaUrLcvVoJJJaGbVRxSZf6IqEyybEoUxfzWmu8KN0fXJoG2flo2mQ6knE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224956; c=relaxed/simple;
	bh=HH2eYt96ABd5SlkhhFODqiVgM3AzBZvbWxT+AkFnToI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiQqiniDjfFgkq4k86GHuGaXOHuhtj1J/B98l1RjWw0KILkcnnUO+FhaAngZAJS7HN7Y+tfA9rI9KVs+5YoggZo4wEuCgY3XnYbk59mxPlia9xkErEsJ8WkSI8edbOFe9eCgMBul+POR3c1wFwhONU5bXYfHcsc8gA55jF85SCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d5+5HQVI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483487335c2so69147745e9.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 20:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776224950; x=1776829750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5JWuYIAJ3F3ysqDV+gpo5wAXbYBTGhZvMiJLrtFpXA=;
        b=d5+5HQVINob10T9adKzFdTu6tysjU+9N+uMSb3qLWu0IB9/cli/f76Mjv1xM026QjA
         IwXuYFo9Q6+lhWT2cKIBimWGD3pznZXICiYSm9vOywuV1UyLVnkGsrrq1ixvyMCS4ckM
         rvczA4GEUGrg5HpLoi4hE1c5MfkKFpS4z7wc7p6eWBTSDNTmJIvgtJuF0VTxvIdjOQBZ
         LzFpdz/0d8UPl+kZzeXlbfwNIYWSbc6s3FOSD+VGBvcJbUWqUZrx9KvE8OaFqXcSNhQJ
         7yDZ7ngU4FJ+/1Q2GXSE20HEK/sbPncVREM1c7KcQxuORquf0v8PkLTmz/FwbDB2QFdo
         Dopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776224950; x=1776829750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5JWuYIAJ3F3ysqDV+gpo5wAXbYBTGhZvMiJLrtFpXA=;
        b=bcKj5L/hIV6XsPAzLhT8sM+jgyTHm1O4sO5ssGrLsXZ8SIVzRj+PbYOYwyDw6C7yMc
         MUwMcQQWgjqqqaeIS4ePLtKROf4Uga8tisR8dhonWvI3dMG4IrTVKc5jiMoDqWO+cYz3
         ovpAMHFDTGYsGZsMxTud1k7JS6JSJLvPwhw0OwXxvrsNmvrq+UhgnkR6d6xlyicT+Pi5
         7QScRLJwyPbUCOI5YCp+IkNNn62Ce04xaUT/130J5U1VwkkzUXLgHUwUyAfFdCdfxxdy
         JEn/E1dsyfcIBe/R5DIv9JD/KlOBVbe02rv/haFf1Vz+S9SCPMWvsa+maQ4WIwee1VW5
         qqqA==
X-Gm-Message-State: AOJu0YzkGNBhEkVeKkj3HVqroReKR+td7VQdNS/c912dt9PWcHAqQ8z3
	Hw/feBzB7PuGOGdbNQUWphiyaVQbd/JyWvoWtRKlcFIs9OoLBLWTSlNspv7pb6DFO2s=
X-Gm-Gg: AeBDiesk7gG9IgEKw2l30PVVJAzE5RulwaIBcC8cYpvNwVIQpI71RDtbLwg0sah8kRo
	2WOmjV3Ai4fiC4hOOBD/PqqLCzNWrOFtKyVysmcEGty1wourH/FXxIYSWjqcdQEkHtZDdesADSP
	LqI6//mYp6Umhof1/i//Cks9Dbnakr876gqSbt4PIv7k2/dYnU3hyUIyft2+ME9R8ude4OGHkxN
	BIq1qvAwMUUBtn2pqqtPcbY76aVgEWmEVPie8BWZiOBYNOc/kRW/zDbUBU5lruOzC7d7cnn2T9W
	BITujoowY5ua4wV5LG/OKxhlJ2Bbv0xUETmSZjMQh5J5OD8xzaKy14tp9y5NyNzOZW0T3AeSg3D
	qbBGik+yIVgOuz8yGmcneq/mkOzipIJO3uHwVQjKjStuIYHcpzTN3pFNw2nmjpxzpoew0hCSxmJ
	qWiJXSgVA4WaddoPoYjVlek0ALq+QmDjCsDjQTdFHv+8IPaAKQGX8=
X-Received: by 2002:a05:600c:8207:b0:488:7a24:9ddf with SMTP id 5b1f17b1804b1-488d688dd31mr264696795e9.28.1776224949959;
        Tue, 14 Apr 2026 20:49:09 -0700 (PDT)
Received: from u94a (27-51-0-223.adsl.fetnet.net. [27.51.0.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb8443csm925237eec.14.2026.04.14.20.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:49:08 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:49:00 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
Message-ID: <2ytuw6l77ocy3vefh22hbmugamwlmle4aueyzwkukuhywh6eje@nc6hf2ugu4ny>
References: <20260413155728.181580293@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238023-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: E2A9D400201
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:59:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.82 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/24418242274/job/71333106755

[...]

