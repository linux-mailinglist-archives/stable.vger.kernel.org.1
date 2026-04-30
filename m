Return-Path: <stable+bounces-242088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v7pKBzI282lgygEAu9opvQ
	(envelope-from <stable+bounces-242088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:00:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD204A129B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2547830131D9
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21D3C196F;
	Thu, 30 Apr 2026 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGWyeeSP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3703BED42
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546796; cv=pass; b=oCR5B6NPHhaSJpNatzVe53urEB0uMnfw6VxIEugW8nXGyIK6GG6JygkrCIASFzzuNmJ3QMuDWdkTzI6b/1skE4ts6OMT+swWF2+EiZrVQfClqVDMxEMZ0/VXH42o8FmZqj7hivgJ3LfM1XEEcKgPEyZ2Ve8yrU4BP1dOsqkJaDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546796; c=relaxed/simple;
	bh=WVyjPIFhFCn7s6/UTHOuJlTtYBjTTDJQRviOoUr9mmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VW/10jG4udI0Mrip7ViRakOXQs5v5yE0UkoOkEBv8AjFenHuU/Gg4i5rqMhOULBRLqb8E78XkBmJ8higBfMLqZGgf+uh09sDopxu7phgeU1AwdfdWkejJFd8Oivlm5LUOdYtBTY1cwNYds1GUhoi5FJANK9BmVvE5+/jRgX+Rf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGWyeeSP; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-479ef2b7979so590060b6e.3
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 03:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777546794; cv=none;
        d=google.com; s=arc-20240605;
        b=cA8MzqwMdWXqG/n12G8PMvVfzHJ3bHmD3pqJaqbggkD9yTPIs+u1t30f4JERiSvHBf
         Uvokadhg7rUoGXI5ZypNb+YryTfHCO3JQXQzqgr9t0pEH01HfzKNOUPh4cNr4d3I2YOQ
         uzsyYYg5rFAFTw7drVVqtLmAl0ApOyeuCmwgzg5W6ZMcA5+iYab59IKE9vqI4SChQkVb
         HgFZUM28dtKCL4KsLGeFJM+iwTF7jcFn6WYhtZKMLu/vttn0AXb8MbJJyVV/FEl+5hWW
         1CpBf1lhrriTZ2IUotwup/x+0+vuI5jkngueYYMG2+HhhghxNfi2pju/00RGHbrpYJDl
         sjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=06YwuKfij25TMX2FrMF5o1srZwpTgCpk+Rr9JZBBo8c=;
        fh=i4ldQuvLkxCQd9adDhY9lVjPdVe1xTfKqfq0IR4OAxU=;
        b=PZ8M5E8gA4wDK5MpvgTD8Imndpr38BJ/bR126/dw0fn2Xk9Of1mukmC+Fx/qxCo7ls
         70/c699rl5uKjQq5L0xyzfAwP28qHf+JIaLb6M8b6/HaoaX3cDGD91nUw5K6ocIp1pLV
         KQEnjR7W2l6vI6XhCJ1vR3Tea5CTTOLE9qmUhJopwkkK3PainhJQ1Ot+UGLUXIYyQRv4
         cqo6zCLqIkuvhCiNOAAok4+8oUwplwZ2w4f9T46KYCvn8iFczoFCWzWuo1CI0imLEki8
         Hyut8RY+xC3WQVWiZQGYsVlbo2G2IgHiJzG/R+0aC1mdY+Qnfeq2Zab4WDLpm2aYAmjQ
         nudg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777546794; x=1778151594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06YwuKfij25TMX2FrMF5o1srZwpTgCpk+Rr9JZBBo8c=;
        b=tGWyeeSPM2cK5MbY7lBq3BoqeXxRFwQtMhrZQ+B6U68fMGQzJvkiem/zdT+Wmfw9CR
         k+9fD2twwZaxWMAfiDnvn/BUrfclFQ2to1Y/UUyw24KY6Vvk8hkwMTKl6VgffoHVbIDW
         abbtLWj2MoJaVqA8VeDnZdNX8w1Ui1+6AuWQwcZA9TPHpKb+mv/WHwrCPmRp/58oSlGy
         19GgqdXHYyTQuzKQ2giivHJrIxHospqVbBrSgUAIYCz4xYnwgu3obUSzaPdLxOuilE2x
         JjQvy5cMx7gzmPJn6MBovGiDZK0Y3RL3/oOs4xD+EWQ2FM3PSTTHsf/jbsDkXFxc7Jlq
         M8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777546794; x=1778151594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06YwuKfij25TMX2FrMF5o1srZwpTgCpk+Rr9JZBBo8c=;
        b=V1UFufhLdgb7M3UL33/Djgd10xMWTmTWiXBLAj9XzWlylLUcO1GR5EG/4oM2vnYmnU
         QG9hTcRwT5KpZyQJeNsGiIOd1MdWVmjXJDbN6hxiIawBk3Gb21foUW6rOMGFXpUs3+33
         zpm4q0JNLBGTJEHD/wgldUzzLUewRtCaGSMKEXk8J1FaKAsYLj7hKKy6FSe++0OJ1VEC
         ZWWOAZP/vOiYdJlh4Fqo14OEg7pIz4Nc7otSszDdV9JcMZ2OVYMpvmNbnpdC15DzufxB
         eNgTPvbZJrYnAXx6DMd71AG/G73M8DPx+72hdbx1Qtr45+9KEsVFt2MibaNPGVcDBBc+
         7L5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8KdG1x5JNwA5UM2MgCbQP5VYbvG0xPeoh/tOeGJ8bo1SeogjR3yPCGpbiTUY259MpCMteNMis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwktW/sjgn0Uq8lMyn9iSEAShZp3ObeW11bU21Q2dJHnKUNvaKt
	7CjYeg/vkE1N71KD10FVhVFCZL1UZ7MQhizGuM6yekbIrVzlS2HkSMgkwEAOZqiZ4CTOL43me2l
	PpWMhW0Gw1Rp+VS4yrPpsyQgsk9sYzG8=
X-Gm-Gg: AeBDiev3rwLdWN1qo2KaoqzKjBVBkRY/SwJcwX0OzFQ+saN32Tj9ooZ4gg84zS7QyG8
	XFIXCxx2RLMV/+p8CJbGuK+pfCFSCtnq3+4/9WqQlVDs+4iExivW4KVD+vYiMYJAJw1FcPxwFyG
	k/MtsnoHW7Ij4yYwvd33uc0HAmN6u9ChCcGcEId8gM1adas0t0OMEx0UCH3tXZND99k+1dWZbA0
	Gv5zV+q3XnyccLa9MoyplJoNKgFHD031Dxw6QZsFA40VFjAQlLzdkW3KVjNDolHmwcxQLPL/mkm
	BgGTBVdSu1wsxKBpdRFj8OIXvtNIgdR1Vmd/pRSvWCpvuNVZ
X-Received: by 2002:a05:6808:2519:b0:467:1212:46fd with SMTP id
 5614622812f47-47c5fd77dafmr1043697b6e.33.1777546793717; Thu, 30 Apr 2026
 03:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430062033.20428-1-devnexen@gmail.com> <700329b9-e4b5-434e-9678-5a7f067a535a@gmail.com>
In-Reply-To: <700329b9-e4b5-434e-9678-5a7f067a535a@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 30 Apr 2026 11:59:42 +0100
X-Gm-Features: AVHnY4I9ukprlWisCYaFhCUtcKRssHArK9YkwSe2zPdGGSdz7gLHlpvQiZUShmc
Message-ID: <CA+XhMqyOSDFTwfbkBgvOw0GOu6KXT3-VmXimqFrg=rQrKFEGbw@mail.gmail.com>
Subject: Re: [PATCH] psp: reject packets carrying unsupported PSP optional fields
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, raeds@nvidia.com, 
	kees@kernel.org, cratiu@nvidia.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AFD204A129B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242088-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi

 > [...] we should fix it by validating that it is less than the
  > remaining bytes after the psp-udp header, and then stripping the
  > correct header length accordingly.

  Makes sense, I'll respin to compute the strip length from
  psph->hdrlen (after a second pskb_may_pull to bring the option
  bytes in) and drop the rejection -- easier to ignore VC/options
  than to refuse them.

  > For the other two, I'm not sure they are really necessary.

  Will drop both, agreed.

  > [...] this function will also need a comment update [...]

  Will refresh the kerneldoc.

  > For a fix, you'll need to target the net tree with this patch

  Ack, will rebase on net for v2.

  Thanks,

