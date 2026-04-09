Return-Path: <stable+bounces-235312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDHUJEtE12ksMAgAu9opvQ
	(envelope-from <stable+bounces-235312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:16:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B870C3C682C
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9ECBB300B2B6
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3502314A90;
	Thu,  9 Apr 2026 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hd0rW/aI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614452F3C0E
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775715397; cv=none; b=EZsJv6eAdIscbupVvjQ0L72IIDmAQo1gHC+H7UJ7ut/zd1yveY7EdvjbGCa7xfXBlhPxrkmRmg3IrXGGzt44rp3TAGF4wKgI78G37StoC8PPWwVLmF18Zsz6SIMF5TviINmoINOcnApFLNPoZzZsSzIwxLMVptA5XE0tMYSo4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775715397; c=relaxed/simple;
	bh=6mtZ2X/mdA60+76qSb3+Yz+RcEgdrZe9vvYKjMR4EV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjLWEKsZNNC5v3ZzaSrE62G23hOLBwrzYUkMp03Dkrke3fkZiwlCoX8SKbfhQNoV8Ze0LmkVNcsvUakzr8Qq273sjC8QHM00eDMAx/i11utucuIus996Gs3MZraDGuouaDHpBFgLYogy15r8faMz/ZFxUu1Al28+Gk7Gf5IvAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hd0rW/aI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso5013595e9.3
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 23:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775715394; x=1776320194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pwoe3OCa92TGfyBz5HTxfCfcGY3puyChc6eX9sLAHM=;
        b=Hd0rW/aIjAq8kgmwINIZGXsk8HBYdiEOy29tZPsUNH++v1hvgx0mR7Bu+SVCkmm1Iq
         0x9xnjd7DIRYx7IrPgoksTOOxpLaei8YvEdyCX99grxAEUBRdXkT3YC3o+rxFyvLW5RK
         DruzDvmB14dxYLkfnNhdxe7t6bNmJGlkgKwiMnT0GLT3thvUqm1rGtBFSIn46lD/HJCH
         JhcYe1bwO/QTyJD8YPjOqEeQ176VTSzE8urK41/rwLfQDJW1oPfsevaeOOR02n5pjobT
         wjc6jj7zlmHhM794dr1mZnfgJPC0TNYzZj81W8cHkYWHM+6AET37aGlpC0z0SP8te03C
         tKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775715394; x=1776320194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pwoe3OCa92TGfyBz5HTxfCfcGY3puyChc6eX9sLAHM=;
        b=edfavLrFF+RTWt5aIfzWkyFdneNNZyqgOQ4oPFYjnM6w4Tp57SGwFFenb7kZPbJ46W
         zxSZh2sLn0DP30eJTKGYQ9Gyz7QrSD53ooAZGK5vlaDaHxkHP4zseB8/f3M8TZ8c2/bB
         9Y/aGL2jW4yMqAPL65LCDLlGJFAMvtm7J/PKP6eXXvIQRvYmmszLV2pigWsUrGwxznNq
         t1gJ/YWWjARIqmKBtPqKuHVR1kPYG7XYM2AOkBjd/mEZ5lyi+AjwXt3cgod57fULEq0t
         BPchsxCixyVcg23wxn6Bc0yiHt9B6rVevAPFosQg64zOq9iJzjZ6nxTo1XjNKl6PBmeV
         GysQ==
X-Gm-Message-State: AOJu0YxT1rcf9Yo/Ka86BGQjHEhznndy855RPFMjWfHQqB/NqifUzv9x
	j5Uy7HUiQU9oGIiP+L8Bc1YEC0qYVCL5phFvuorkfNHXG7HnwEAqMPrpMgXkiEa+N58=
X-Gm-Gg: AeBDieudAejaPxC3vFVDK6qAqn6nOjyd4PMfzVhQDmh44Jiu5YZznk9RRtbLGUJ8Pvf
	8rR6nPXz80ZRGoS8hAEg+XzWFUvhUYeE0gbKDlY8ZESUXUo1XZ3gjH/2LU+Qgr2QYVg2iKy6Sdv
	9Qeraf6bNzfIZiJPCWznnXC6lJrsusLBln+21PPdgrNzDnkV4raX3LGHWZFq12z4qaJcX0M+VOu
	Uh/ZTHDYObXKgaghjfog0AXzpBbMJEUncsOTzdU8zEA0Ue+5GQoV2nk6itkXgOUQcOrXCRFyD/K
	bCI0p3BwtxaveiODVC4Wu0n8jsC9MdJgE8UE/JU5rs07hr+29KJG4yUA4EHf9a1nQwPRLdPE9C2
	+AOyWFwI526mdyaqvJCYAf/n5VK+cUGA1gERqE2v/OVgyjPERstlKoU9vV9+WxU33yO4SH+g5kj
	3cu0nMT7p+1p6LKuiLAYvL+A5Jq9fZMqH/46I/UaziYl8RKPpz
X-Received: by 2002:a05:600c:c10f:b0:488:869c:edaa with SMTP id 5b1f17b1804b1-488ccfa937dmr21335925e9.7.1775715393819;
        Wed, 08 Apr 2026 23:16:33 -0700 (PDT)
Received: from u94a (114-140-130-35.adsl.fetnet.net. [114.140.130.35])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fbac435dsm17406228241.11.2026.04.08.23.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 23:16:32 -0700 (PDT)
Date: Thu, 9 Apr 2026 14:16:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/277] 6.18.22-rc1 review
Message-ID: <7w3vhnc4trepnsgwqp7qotxre3crgpnsenqnupxec4d6z6gmev@l2eh3sbjfb7g>
References: <20260408175933.836769063@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235312-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: B870C3C682C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 07:59:45PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.22 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/24153838933/job/70487760128

[...]

