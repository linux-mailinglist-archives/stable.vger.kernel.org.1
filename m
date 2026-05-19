Return-Path: <stable+bounces-249663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGxQNb6vDGrdkwUAu9opvQ
	(envelope-from <stable+bounces-249663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:45:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A076583D70
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BACA73018BEF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E636C592;
	Tue, 19 May 2026 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CjXYt/rM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430036C5A1
	for <stable@vger.kernel.org>; Tue, 19 May 2026 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216277; cv=pass; b=ibGxrFWjcyl9Yq4/8YRtNvF7lJ+qCB4G7XyjBH3OUBLLr8eH97wLEuFkepsNwzWY3nG4GhkR8LXCpybDcT6GebDlty8+dkUBPk3sDfKU7sR8AiwKsGc9uHVe1sob6VEGH0dIglkwQ/E2WHxuFH/dci+QNfkhVZ0mD+2rgrtU2eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216277; c=relaxed/simple;
	bh=m/EAcZcTn6YCQmn04f1HETEz/3dphlIh+EGb82rCEJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqe0R8+z49HlwtAqOqx7hHyUHOb70lgjpKwn+PJoTaEzpIxzmiB6mgWTZGcZRp6Y1ti74AZuqrcQxfK4qAiNb/FbU/Hg9nyZIh/27lk1Nx7x3Mp/iz1SWHIlxqjQvkC0H/cDj3ez4c8a0c26/FstH3ESArRcrbfoOlqJVv7Q+uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CjXYt/rM; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8f9841616so3487992e87.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 11:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216275; cv=none;
        d=google.com; s=arc-20240605;
        b=OPSRfzaS0GAVnHUQAxoNOS1cV6mfmAF3LHz4z0YXuUaGdGTeKKjBkQ72nuzkHr8ebf
         Pt5VBFwHcpbRn7dCo+l2mZeK0txWwba3dfcx3Des7is5XwizzlcD1JpcGWhU58T0xdLt
         IJJ7pYOUn/bUmUV8KV0auwrhOuQR1KsHZgWEsIO+azeApI5QuLXxLo2qOWU6Pjt2Ri2W
         QWgvfXrPcCk5KXKZR+YU9t8j4ATua6QK7cnY3S0GQapXJBncQrqZi5BS5QusbFcv2dK9
         7sVPHgp4KbXzgmuwpi+hr7+j/vJ23HjUFr9PpJJxk5e5rPSQTJ0NstW6yD2lNiV+xVMr
         UUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m/EAcZcTn6YCQmn04f1HETEz/3dphlIh+EGb82rCEJ8=;
        fh=S7uujp4HB0vmCX0H+Ac5yztmRWy0ALE2ZWUOG1cq6MI=;
        b=SOre6fYCiWfze8OrAgb5Vjbi3hMtGjGLYh8ZmcubEbascOAYkvaMiVeuFhY2V34om9
         Q6+sv7ZzTKUzoqxBwh1vWNSb+SjcnmZ3mBYKJ0gtCkNHmOrSshJERGBpgqu3P0cmoghK
         cLT4mr8FGSxV8hHnEjs5ZqMkt+Wqib/Ydr01qz+QCPMKNZ0B4Q9hfsmYSfAJasULJ7ZS
         5ILzV7xztqa9zLF768WM0d23R4Gr7cygQPLa/YdUKWvXC16q5eCR9rc1DeGqpUVpTRha
         nYf9RckmCSUiR4fSqnMNI+Z4SEh1IUyOUSTnEcPULV2QPIUgdkSItahYfQKoGrzJH/Yc
         z8uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216275; x=1779821075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/EAcZcTn6YCQmn04f1HETEz/3dphlIh+EGb82rCEJ8=;
        b=CjXYt/rM6coWQYt2t8YR2NqsESlUvukMrn47iFzTvIawl8CGe8Qy7axvDNwjc5UkR9
         QzI+9v9PlSKmtvbWOqHJ2ozq/rGfZ0xrjpOSm4pLQsi0N4Fo2+5uccYWMou+SF2Fur3F
         DzqP+b2QVuQUQEt2ARvwHWpfMnRIyj1dL7ly4c5JOIHMPNatt4i5NEiXbBgouoTGw0Rk
         hSC+18/D90cL8vY0ng77zZjr15bboqFfcX4RQhGk7b+2bjqOLKp/9/1OFaPTc+yPPeQo
         T93TK784iE8AWCB7HtdCDxfDSxquZVahB0mC5yqwXVfPbmeeij1nVYXPuxIdx0+YPqdZ
         bJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216275; x=1779821075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/EAcZcTn6YCQmn04f1HETEz/3dphlIh+EGb82rCEJ8=;
        b=b3gr3zAXDZoqPssnknmVVD6g6pMV9fTqvS/+at5iqJV+tZu+kWzYwTNqF8wGWNfb77
         IAymIuaiS7GlLuQUEZ89Zlee3DwgEGJRz1EonvS6KRBZ8Jmrsu74XtUfmxmj9A9loA3X
         AFmhfCIim+kZRqZaYQdDESjlJ1XqL8SCTeCDHkzGszxZaLBJu5zzRbrzEjBPQ5VwYPSU
         0J5YwQ8rq7TKsEPUhVT1qqJz6gJykJIip8VvS6jZPrwDLsQ8mnxeKftmeU4csDp8jpUh
         taCajwSIFIzN4FTpf99Em5as07srnZwMdGlObL/a9isiTcjWZN3gh72MWp81kWlUsKLS
         PVLA==
X-Forwarded-Encrypted: i=1; AFNElJ+nijSdi8r7LjOaQA0gGUWidxKjKib5e73I5lV6fcxVfUDdVA704H6k6Jlt/26rgEJdKpvh+kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ7A5HzNo5syYZSwdlj5x4ydQ1/01WSx3q2QqHnAY9sJY7lrSg
	1RCLm1ta/nr/W90zbXwdpF9cEiDBARH7mD7WQ7vjTVZ9pOw69Q/q9+rMJGpUF/V/Lug6UlG3a8L
	3tbb0+FZ6jCPBfjKKVdSBChVhiycxreEk5V7rBCpA
X-Gm-Gg: Acq92OE6azZmT3Ac8cLN4qPWNW1cXd59C+rZphjPJ72IZ7EpS1VaLGGqrh29Kkt0izv
	1VUwHHR9zE1pCKCCxuN6qX+FiKHo0r7jXXUdfE8UIHueJ552rNkrXLCnrlO7x0ttQVq5i5ecGUG
	vWppMZWh6RpNWtbU1uVFTIZSsTRyfH9UnYaNciAIpHKI++RvrFz47sqbsFklxXZkbOAqjTLUSpy
	wlyE8avwnntMAjfCpPmLN6M+ZCAFiY+8n1aOUzWqeeESGaSKEbOU2c1INeR6gt89BgzOwdF67eK
	9YxABOTQo0KSDIUQo54El7gIwYZZaL0kN02lilHyWWlFbROU
X-Received: by 2002:a05:6512:3b8a:b0:5a8:5187:2e78 with SMTP id
 2adb3069b0e04-5aa0e60ce1fmr6774437e87.13.1779216274409; Tue, 19 May 2026
 11:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
 <20260506202842.1788682-1-kpberry@google.com> <20260506202842.1788682-2-kpberry@google.com>
In-Reply-To: <20260506202842.1788682-2-kpberry@google.com>
From: Kevin Berry <kpberry@google.com>
Date: Tue, 19 May 2026 11:44:22 -0700
X-Gm-Features: AVHnY4I07YE-WIA_io007cKgKvXDT0C8G8Ihgjw4LQXdkugHL2Hp33CpQ9pzB0A
Message-ID: <CAMAJAJFCWdZAhLnKh1gGPf08Pn5XipaXX3Xv_rLNFYpH+WCJzw@mail.gmail.com>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: xmei5@asu.edu
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	pabeni@redhat.com, rnj@google.com, stable@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249663-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,vger.kernel.org,kernel.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3A076583D70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

Just a quick reminder about the patch for the 6.6 tree above. Any
concerns with including that?


Thanks,

Kevin

