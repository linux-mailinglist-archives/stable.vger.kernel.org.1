Return-Path: <stable+bounces-249692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJELDeDFDGp2lwUAu9opvQ
	(envelope-from <stable+bounces-249692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 22:19:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CAC58496A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 22:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7566B301BC29
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA60D3BAD81;
	Tue, 19 May 2026 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKu+MBJf"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBD2E7F2C
	for <stable@vger.kernel.org>; Tue, 19 May 2026 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221976; cv=pass; b=qYLjBipTdScUJgX7anCMqRY6T7nJHENKr13zJreK6AtgYvqia7lGD4vajp1sd2ZtnTzyj0kgdFchWXFzlsJ76Tkezcs6Ig2vZ8xFwE1RyDB6XEYx9sT6HOXs3AzFpAIw8X5MQUwAl9d8qFQsi45icl8F9GgtQ4f50ZcUKmrP2aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221976; c=relaxed/simple;
	bh=uVwZDmA/DiiIDGng7o/FHq145x3NdX3CHZlkoNsYa/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X87tD7Ddyc3cYbZMPW9e1WlDQ4er04kXWKwrNgYy6Q4d0JJCwS6hc1kQqUVQIqGG3x3M/tr0//dRT/XHIY3lRvxo6D14BlpMRo8QIjnk4bXtbcqhNZ5IMB90jpInPOXPSgtGDbact7XbJ7RZlNN7F161dBt7MGRZDls0pA7du1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKu+MBJf; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-68470763896so2106390eaf.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 13:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779221974; cv=none;
        d=google.com; s=arc-20240605;
        b=iUS1hPCIhYi4u5Kk/pUTevGQ8HMJhKkCYmbg6O8JqrCZ3lgpSpEcdjAB69Z6H5dUCr
         QtIVDNfL+Yq+OrUZLpt+IODKH3GnnAYui+p0QlImm5zKyeh7J/ucXy2iQ3EkCoPIM3sy
         546EeXOhc1kBi2mPELzXCy2osfZFEdPc6+el88rrsDm4o8+Y93n98vJqnfICKWfxELui
         E2GCBUU7HjFPEXjFXyS3XkaES+qttRc5gCYk6nL6i1Djs6uoiqFLO2L2jdkmj4A/JkTD
         VYsFuvfEEGl0ohstd54ahSkyb3Z9brxgBijWOfdTbH8/6Tx9vian8mkGWrJnIRZPSdiy
         9Y6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EDC3bKh8/p4QwHADrhgrb3dyAQ2dl37DGNBILQ8Vl0Y=;
        fh=xIJdyoGkH/3wyS7IbBuOhT0pJWk+GB350MMBgPKw3nc=;
        b=ZHlFJcc7APzE6qskozUpyKXT/cJAs0f0UYKm/ZVGzhYczqIWnmwuYS6jX6omFIzeKA
         oCD6Y9+gAdmLToG5dQyhTaDwLA5DFhxutb0QEU/387MwMd430EYHgrh+N68FLiRNZsmT
         L+7Wa/bWbc/WPzgZZU1ouipQXqwpe1IU7JCN8XThCENKPz6L2wvA+xveLlJhqHi+W/S0
         LGbFQ1V6ZlpvlUYKJrPpP3nSbmUMVWFiwrgNYV+bZ9TBzTD6s5CBxese8o2NUJONjBi3
         yvAgNAWIevrS4d0pzi/wiafEatlHWV+HMLm/oClvayGFMQlGw3qbc7UQbsoxmEijVeL0
         gnsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779221974; x=1779826774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EDC3bKh8/p4QwHADrhgrb3dyAQ2dl37DGNBILQ8Vl0Y=;
        b=kKu+MBJfcOLpMf6mpsu6AD8GrFTa00enG3tFLECBLBXiIMV52HQA9EECnf2gRV2YbY
         dX81E0k64omJlWOwRAbtkR6sKkaP7+dDtRkS99v1IWRcyMn6CjT1RWGb/QZe8FgKVxx0
         tH1SriXOjdyOMtZVKc/AvQaUVYO5J7I5R5kmpdRNBMZBelzQXh9g6i/F/1BnxViEKI6k
         5U+JcMCdV+Z8OTc2D8JpHfQ4g/VrXPSh31xQeD6pZGUH2PLOITPxDgMMpWMFSMyXMAD9
         A4ltVJDRNfTK9k/siexqbKgtifVDKZ2G9BWbJJVEmVe0hJdDuKkzGPCAT/ua75ej1Vwn
         on5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221974; x=1779826774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDC3bKh8/p4QwHADrhgrb3dyAQ2dl37DGNBILQ8Vl0Y=;
        b=K0sQ9Om+jfqVibibs/+3DouNIGrN5eX7mRJgqxMUniUHwObf8g0gVcWlZzTPpxn+Ku
         lbmTVnQCcN6dhSqVbJcpkhxG6xBASFUi6ES8h65v98gH/qX7BY08qQnLXsNujm/bq10S
         XPBm4qgce++wKX+9SrnTftuAXz91s3/b+3W2YDk/jGIFAXFI0T7FoTH79OR9YALnMkZI
         EFB2VTF/nXvlYRrf2zM5aeKPwocJDo7MnpCQ9WuMJYkGKfH3KtOPxhbAxD6BjzLS1G3I
         8TLtPwE3e1+sH49miT7obWAXPdZNzz1KRqzjzeg6HbRRZsM0Qg1VBCTtgf8AWvGWGz3f
         lQig==
X-Forwarded-Encrypted: i=1; AFNElJ/0McbqDawibDGSHRKX7Bckh1tmHYhtEfTeMX/zQkBn2fO1Q13+5w4nQf+ZDGozV/bs8lKCVgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRGhnE3CCNT+h3nzLQpumLOJlmDtVK5xGQHQ88+YmqityNK0W
	w7VN1q5adsWHZZY6Gg+IA01BrBcynWbsu3OJAdfjorl+JfQ8ng2YTW30XL3EaSuo6K/z+K6UkHD
	F3BnqNG7OvtvAqL5JzOmaXiPey4GtKfE=
X-Gm-Gg: Acq92OGohlIV+kIyaQLuYr0z271Kx+LJrjEaRNguuuB28lqnx8Iv5mM/rorLTNtYATi
	V/873VKtA1sBY9EIf/kMeE4TIGOft/uo5WzdpXvVO/EQFK1fhJ3a/yMgyFcKly90kWqxJM3MhD4
	7y9pvaOWWkXLRmr7VSmejzv6TecMaP5Z7IerxiMjAcjY/1JQdw4uCht+Pt5ccTDr9Z6TE+rwtv2
	VwSZDEBsnanO4gB3JH80ePkOd+SvIEUVrS+QoOdVWoOK+I/yNHHHjE9eBfKtWRKtzSAce1IUqjs
	WOMFa1CX1msLzQ2IM8o6EtmwzwTGROTIl+ScrA==
X-Received: by 2002:a05:6820:8184:b0:696:15ed:69fa with SMTP id
 006d021491bc7-69c94588db6mr13429873eaf.48.1779221974374; Tue, 19 May 2026
 13:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514183019.49527-1-devnexen@gmail.com> <20260519195734.982404-1-horms@kernel.org>
In-Reply-To: <20260519195734.982404-1-horms@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 19 May 2026 21:19:23 +0100
X-Gm-Features: AVHnY4JJ0Sk-6eRtWSkgzWM6vbD_3Px-KdWLRziSGPAucGEK3w1KDvkaEUsVkxI
Message-ID: <CA+XhMqxFmJm_fQ9aqRmwbG10+Bs8RgJ5kAff9-qtcrvgmfFMug@mail.gmail.com>
Subject: Re: [PATCH net v2] idpf: handle NULL adev in idpf_idc_vdev_mtu_event
To: Simon Horman <horms@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249692-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C8CAC58496A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This is an AI-generated review of your patch. The human sending this
  > email has considered the AI review valid, or at least plausible.

  Thanks for relaying this, Simon.

  The scenario this patch fixes is sequential, not concurrent:
  idpf_idc_vport_dev_ctrl(adapter, false) has already returned and
  vdev_info->adev is NULL by the time ndo_change_mtu reaches
  idpf_idc_vdev_mtu_event(). The original code dereferenced
  vdev_info->adev in device_lock() before the NULL check and oopses
  deterministically; READ_ONCE() + early-return resolves that.

  A truly concurrent idpf_idc_vport_dev_ctrl(_, false) racing an
  in-flight MTU event is a separate, pre-existing window: the original
  code took no reference between reading vdev_info->adev and
  dereferencing it either, so this patch neither introduces nor widens
  it. I haven't constructed a concrete interleaving against auxiliary-bus
  teardown and have no report of it triggering.

  Happy to post a follow-up bracketing the handler with
  get_device()/put_device() if you'd prefer, but I'd rather keep this
  one scoped to the Fixes: target.

Cheers.

