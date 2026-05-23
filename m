Return-Path: <stable+bounces-253911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F2lFbVsEWpLlwYAu9opvQ
	(envelope-from <stable+bounces-253911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:00:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A44F35BE120
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A5830276AB
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76837FF64;
	Sat, 23 May 2026 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R86vouQV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245AB37FF43
	for <stable@vger.kernel.org>; Sat, 23 May 2026 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779526700; cv=none; b=OfjEsiJAUKFB5vdZsOMRG7V6coei7y8OwglW/1IEAI7d05PxVO5iZTLfcN9U233AXYZJ4BQJESsLZDvGPzZobyYe8aUpuAXj8568rtffq2O8ls4RQPT2CTQhJ88Q/7/pPahm5R0nO8onPSORk/mn9yVXnkjWTs0ldZz2zbefh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779526700; c=relaxed/simple;
	bh=HFuauo/R/DdqeAYPIpnc7Zt+6L1MoBuerEr2NwcI18A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kv2v8qSyiOXW6GXrNEDd/noCfn42XgqS+GuvBsOgkCuhKPvhwFxIEIIMMDu/C8z/WHteFVVK8Ee+nAahwhmSaM1lRsXHTN3MD0Bmukfe1Ata9JKSsjLTtYUbN8ycsYOweEpEEEz2jBzjclZRggrnVRFQD3/3J99/KJ0PQG4Jatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R86vouQV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so7275858a91.2
        for <stable@vger.kernel.org>; Sat, 23 May 2026 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779526698; x=1780131498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta9Hhm/O5mRGfpKzafCBp6sb1vl/zPPnwuKJ/b1Ef4U=;
        b=R86vouQViAFR7Lz9U4suLf/Xuc3dNWArhge3NXamXAPTSIYRYakIfpGZgZOyED+r2p
         +96KiiNmj90I3ega8+nO9SJxlEvcAk9je6YB2NaJmMvTdmayuw0I/r/EZtcPIlhrpNCJ
         DinHqofISWVufsybpVjJTv1acvWCRp2WtJ8jhdykbtSLZ1Yq/xjPdNKI2uAOdkG9Makw
         zz2mirkeKw/LUK6WusX+vafZm9vYXcpEXL9eXv20FvVONxtkAtdqy8WChclGpLx5Q7MX
         G1wlF6Y3tcRRWBsC8z2coAtbhkkITlXBDAaZq+zD7OZOJhHNMRiwq8Ju5obSdnvk7Yoo
         4r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779526698; x=1780131498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ta9Hhm/O5mRGfpKzafCBp6sb1vl/zPPnwuKJ/b1Ef4U=;
        b=FM0K1UNZeSUWNe8Rxc9WLQ764U5A4Bu2b7Bwm9s4tMj7Tc4EsjsEPIJpZiUPOr3U+l
         NUEjv6Qmzz2SJizOyHB/lRdyzdeDJn8nPmpixwCjqFs1LBtpyYyz1J50mg3bHANw9JH8
         /m7P1yeltVrM2Gc5UniJv7CH8DoGJx4Td/1qHEb1Vpk3Hz2U4WChtWqBcw1Ek7/rJGdF
         zFTS/8uMEOWH3VJuF5NN7pdQNvXl+ZrlnEwQyqhPh7dom63eLeWT6vplzMA+LCdW1dh3
         RN/kgQTKI6SFqxwfmBrOYf57/PYLnIJMLLQAndZ01cKhSEPjSOgohfpqOriz5k43r3Ln
         0z0w==
X-Forwarded-Encrypted: i=1; AFNElJ/at8NhyjYKXz6weGpxujeGme+DjRB8WfIvfcyhGNR6bzcdFaSLOfAO8C2CjMOHY6H4RXx6o0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGqQl55igG4FcfKSlrUa/WxoUR9QX8mynez4Uy5Dso8Yi+hel
	39OBhKatM+d0tBxG5Z7wK+QoUKY+Bsy1Cs1xXW59mfA1j+b6Mcrh3mHJM5eMbqraZ6zOvw==
X-Gm-Gg: Acq92OGAQZyaAQLSl6AqVhpVmjDGtZSWUjW9FRXXa6JBbS4zvtYHuruTw6a2p6pjoRt
	kyqmLMyXSHqBNeq3a1KQdgkYdFSMKDqztKSMzYqoU/HJTsugtOQnNdQVSiA+Wg4+PvOJNrc3lN4
	t6pAYdF4qvKOH+WJxgWmj/Fd36JnfXdRb8lwhoegXAZ5gEoAdmczxRdeOPLtdeBwETaW7Smoevz
	QezCvSS22BzUlvFav7pNmywwQt0sVTvxbGYcLCj25ACjdX+t6WjErpCQ4QYkEZm0SGEucP7DA7P
	QsTJbbNpapBOWoF/KVnkKIyJ1JKQBCCcOoc32ImXB9BHUG/NKYW6tC8pn0o7l5aXjhgCE/iIEcb
	dSiqZstAm51gGMHmKCe8KJ4aRmfXQC4B420VzlTz/0BxL5mV9FU5GQs+3q+I45V1Jxcf2SOtaHo
	ZzPVWNYE0jmSojNsfDudgt3P2MeX5fq6sWU3RV+cOy
X-Received: by 2002:a17:90b:3505:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36a671ddedcmr7040382a91.0.1779526698191;
        Sat, 23 May 2026 01:58:18 -0700 (PDT)
Received: from ip6-dynamic-adsl.viettel.vn ([2a09:bac5:55f8:25af::3c1:44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a723cee01sm3873352a91.14.2026.05.23.01.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 01:58:17 -0700 (PDT)
From: lazyming <minhnguyen.080505@gmail.com>
X-Google-Original-From: lazyming <nvminh232@clc.fitus.edu.vn>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	w@1wt.eu,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: skbuff: fix missing zerocopy reference in pskb_carve helpers
Date: Sat, 23 May 2026 15:58:09 +0700
Message-ID: <20260523085809.26331-1-nvminh232@clc.fitus.edu.vn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[minhnguyen080505@gmail.com,stable@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-253911-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[clc.fitus.edu.vn:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A44F35BE120
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I reviewed the Sashiko AI review of this patch and it raised two
issues worth noting:

1. Stale shinfo after skb_orphan_frags (vhost_net path) -- this can
   lead to UAF when skb_zcopy_clear() fires on a destructor_arg that
   was already freed by skb_copy_ubufs().

2. SKBFL_MANAGED_FRAG_REFS page ref leak (io_uring path) -- page refs
   from skb_frag_ref() are never released because skb_release_data()
   skips __skb_frag_unref() when MANAGED_FRAG_REFS is set.

Both are pre-existing bugs in the carve helpers, not introduced by
this patch. This patch only fixes the missing net_zcopy_get() for the
MSG_ZEROCOPY TCP path (SKBFL_ZEROCOPY_ENABLE without SKBFL_SHARED_FRAG),
which is unrelated to either issue above.

Could you re-review this patch? Issue 1 in particular looks genuinely
dangerous and probably deserves a separate fix from someone familiar
with the vhost_net zcopy path.

