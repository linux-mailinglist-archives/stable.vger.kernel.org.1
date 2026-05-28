Return-Path: <stable+bounces-255083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I5zMiuIGGpnkwgAu9opvQ
	(envelope-from <stable+bounces-255083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:23:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D65F63A8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2FF73015E18
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D291408012;
	Thu, 28 May 2026 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGVLDZma"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04FC3F9284
	for <stable@vger.kernel.org>; Thu, 28 May 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992305; cv=none; b=i4TmcmGPGda6JUK8gjw4UkxcohmcabSfgNIwiP65vX3oYIA+3JUh7RFFI6/S2hMFOENf9SiuBZ3lJoEiUIBwfjLZqUgfvdEUQtZGk6MILdapnkzpRmbkHydPqb4hV5ajwrKYxEWe+snMQ7NgeUKTNFDfU4H2nCFiGSDUdqCbwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992305; c=relaxed/simple;
	bh=Z9mUKXiFMeHB0rQaBpHPpPm5OrbDjN0t7uWm4dendnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsMdX/1N/2A5RHM+0P6ndGU1GtWhcOqSEw6zkf3MNEx9+6/YBUDc4RLNQcQpCxxak+mhsz+MOxdUbpUSB3IbOaaA3ZfwDz7Hg7UrkfRqhfz8kFA6UXPZbEVDXWd60/IDipGEddWjkRVypPWMhqS0KvUuNcZEyVWWwsmFtgQ3W5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGVLDZma; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bd5b3f8a98so23702555ad.2
        for <stable@vger.kernel.org>; Thu, 28 May 2026 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779992303; x=1780597103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pm8Ai00GQkKOLkj5phYZQ5dpFj147opmWg3JCHk5dlA=;
        b=jGVLDZmaD4p6pKHTGanAQTr/MLE7Y2lemO3L6tA1FxYVW64Z442JbYFY5WQ3ZiJvJu
         VvMz5KrMfnAMLuodOgr4zTrbWOvMW+Bhp5PNQCUWma3Xt/Kq3fOT6U7uuw0V/or1M4Yu
         PBu5lnFl7EajKv45iw8Hmrlg1+nK5L/GN8u4Xb5xmnttqkADb+wwiDwwaVB6kacPqb9Y
         h5SOSAy3Pr/LKt6UfGLZfnde15lzmhyM3NDJ2Eu66lXZsvHRtiZqr4Gq3WmV2BD0cMZd
         VhUm/H5YZybVtFBjDgsgglU2UmGQSTkptnnBenMrXNPvOyPrBoIera4E9JUjNpC5SqGp
         XbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992303; x=1780597103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pm8Ai00GQkKOLkj5phYZQ5dpFj147opmWg3JCHk5dlA=;
        b=FHreSCTc58iV5sESVJdWsgq3T4ITHL6VnbxLxLmSHrnCERE8D1VjvfTO7rovTpRjnd
         mpWatEMTbzZmhvqVZ89hcrdEjZ8Laj6U/IFZGXOZoH1J6EpEnGGV1S/RzLkAMPnS6a9u
         PWD1tLzdwfI4De1GcRCrZiGO6QV7OzJzA9z80jptQwTnRVTjxOvGYrbyeODaZKqkQT3E
         llHvjq+svVxbBXZszIPnCNzcbwn77ePPAFpSnM90kesNRuNnNEQPYLgSM3djn3GuaWEB
         DT8H4J8dcEqB+hiJDi8vAD9kh664Pb8y4h5e6+PeQ4A13YP4fFzmZAtdbKGgr1Td4NOA
         Kanw==
X-Forwarded-Encrypted: i=1; AFNElJ/KzAqHeqAXVi9oQQsyuNqTmCt+KI4H4hty17Xb2Z7UIxURuW7qqXIs0qvY1uFiCd4KtzhwnXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RRLzT1ORhUWXwYeREjI/+u/xqvJcWE8AXxOdqeo5MgBP5TSd
	xAQmxKpuwYbF7FqdDQTE1ft23/RtOZl5Onh1ZrceBv5UaA2eguI7oldXTvwzRfDW
X-Gm-Gg: Acq92OH2rtKUwQ7OUdKdJTKbxK1SkrAuib8ZGC5MZs4Vc994jLGNqK6tIzbbVjfJA42
	zLyCoQW9mtOtks3Tc6Q3gwiEIfrYI2cGskCyDxQqRkfMXFIP2Q0k0Y+SsDWCmWULzANSe+yUtqD
	R2BlUdiGf2PraJs0gPhwl5jZXoEyxLKdfyzNFPe9DZpoDubsg0hLYuY/jSLW4vbVPDUimzmZI1v
	NcYZ+qiG6otlkSotxnRV6JYOv3j6bybqLXkRjVQHVuZe2gNpEdKWwJwKvHbKkGNVWUiO/vXN4j6
	1FI4zmceetXNS8zY6vsSoPzWQF3NuXUvpV+e6Wvq6mbs+pg4EA9/2bvGBWwCMpRqcJ+M49UaxSg
	aKyCOQTJEY9SFZ3pH3axBwZFMudreeeUnBGTAozNDANgtK14lEswjLOUm3ijAYf2zt4h0HvOE9+
	mFl/hoFn0gNjKUGDxURkSPkaysVaLp
X-Received: by 2002:a17:903:3c2d:b0:2bd:de3c:a026 with SMTP id d9443c01a7336-2beb066c2bfmr165194085ad.4.1779992303386;
        Thu, 28 May 2026 11:18:23 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1b22986dsm3145435ad.60.2026.05.28.11.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:18:23 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: Slava.Dubeyko@ibm.com
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ceph: fix bare ceph_decode_8 OOB in decode_lockers()
Date: Thu, 28 May 2026 14:17:41 -0400
Message-ID: <20260528181741.880777-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com>
References: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255083-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C8D65F63A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Slava,

Sorry for the confusion here.

The original patch fixing:

*num_lockers = ceph_decode_32(p);

and the later fix for:

*type = ceph_decode_8(p);

were intended as two separate incremental fixes, 

not as replacement versions of the same patch.

I mistakenly labeled the second one as "[PATCH v2]" and also 

sent it as a separate thread, which made the relationship unclear.

I'll resend this properly as a clean patch series.

Thanks,
Pavitra

