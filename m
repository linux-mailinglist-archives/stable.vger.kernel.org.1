Return-Path: <stable+bounces-217311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DAfN3ntlWn7WgIAu9opvQ
	(envelope-from <stable+bounces-217311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:48:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 531DC157DE7
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A0CB300B848
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CA730497C;
	Wed, 18 Feb 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="H7cFUeeU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF69199230
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771433334; cv=pass; b=FLA3nPAavL95QqqmKoj5Uk69HRroCeyopJ8UhySFT9MHOopqNSwHvpc4bru/wn7slx0On3wyshZhLEF9b3Z6xlHOUQVQUePvyLrjwf8XA/WPBlZYrnJ4IK/yIQkEi/2MoUlgorwK0ZQhyJCC3WvlIq1zrP59a5SIPdefVUTkKNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771433334; c=relaxed/simple;
	bh=NDZWkf75fuSFgGmuPbAdFFylXmr6cKJW+FgcMv3BRp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ec+xZ3jnU0NMkJwW5yK0UtCGjIam5AYX5sGMZei5qesOC3cZQSCnRdwdenJ0cTIw4pUnPpTsBliXbxwMAO0b7j3S6YJOsQZHSKH5J4GOtOGhvdrWbz8kuXZHh4Pp7QlTesZl3qlVauYX22adkmdutNpOwrRqZ2Nzy4DbCyGcoWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=H7cFUeeU; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8fbe5719ceso15965466b.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:48:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771433332; cv=none;
        d=google.com; s=arc-20240605;
        b=Awp/2RryBJHJMjtjH/jW66CLcR9Zp15ksDPeIuc8FcCJ+8ge0MKYkDZfoJN6K5xNih
         m6FU+uztXun42QgT1HP+EAGyYC98XlF7UbACFPJ9fno9yF4q6xtOJbHtq7QTJruIPn0a
         xjPL60IAcLON8SJgGdxJ0ZBMunZ9qyTOQnBvcW2CGTn0JznOfEdS+S+9YI9uLzzbiyNd
         Mg0TiVA4mf36U0PJAlNS6WzftR7XHR+bJObQuQBrU2ckubLXRGK91VSJJv1HXgZJyZ9n
         QGsR2YW8L7wfKwlE+fBgswZwK7G/fH3o5p2ZQAInFr43K1UWUUgbeRQEVVgyQbZEOanH
         +pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Sl0EJrX9qWQgs7Bb3+x2webBMo2tPrGnE9i1r6t3N7I=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=JN7ZgDTqEyWh0IeVu9GuzPfPL6vG4Jv2446WVfliCRjqi0juIZOY7Dlhea9LQQZzj7
         Ayy8Ephl/CPrv9AA8fBHoI/TT1MxPfOib8jEz4Fx+tRtVE9hcT1vnQdnG0HIlR8AW6b6
         Ybhv5nw0MjCbhBKppppwAWzDZh1SPGjg3LXEzcC0dTOJ+11IBc1QFcAaL1eFe0nMDUo1
         3SleY91Bk6wJC5ZSo/dICAIdW/j8rQ5S27FUpWj3qd7OgjmzoD1kQ9en9nCxzkXqbD8I
         0jMJvtUHAEpBrr0kZPpHpTdEzXhg05dd4T/H2w0WFmxEMHfNl8Slm62nw5kslz9h3fuM
         scaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1771433332; x=1772038132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl0EJrX9qWQgs7Bb3+x2webBMo2tPrGnE9i1r6t3N7I=;
        b=H7cFUeeUHXbjuqcSgEzUgefwueDlY/BufE2mtLPrBwq1EMdY2JYM/IWhIvL3r8dxst
         oRjEQ4N32gW9CI9jtFr/OT+EqO7xt7tYZY9uO9h208TB5v9JsN3c6luDmC2dS8iuzfq1
         ylu4atmNErYT+DtU9Lhfl9FDHGGso3ZQBhY/ahzLKmSNhVXsGbKTU/sDDBiSDF/7GDzG
         vL9wroICguC8I3nm+S1xtUAwcpH7LNUOFg2KKtQ+2drlh6DdzDy4j+vJPYj/9dd8n3+A
         pQowyx7IPgJiDWe9/fgLNusGG1/LUz5+swTdlOHx5KBVcghqaoV3wFDTrWNhKpOEwGPn
         dqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771433332; x=1772038132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl0EJrX9qWQgs7Bb3+x2webBMo2tPrGnE9i1r6t3N7I=;
        b=KpF6eYfzLdufa1cQt9bTsN5w2fpCgGYhoVs+Fd3ZXDYl4SHwQ/vbEk2FXjmOmgs3fv
         cNGo5eS7sXEcHGMl0zCJ4UJm6/yKQLrxkgixsZ5zNqK9BtEKf1+y0289r/LQyJa69Tuh
         4zKtIqXEDcjsUH8gYIdntVG6UYwI6howm068rpfSA+v0FEo+t0bFQqdmAZ8VixJtmuQx
         ReDEhUNHcdFZiKgsGdFHcyCZk0DE4Hjk/OgU5ky+vXS9/ogM5LhsPWvmbPP7aLxlqWnV
         ARqwtLBI6Jg7q+lnkI6nTm3dHHBb8SB6cd7mdvt8lqK+F9y4+P6Ds88KqQWNy3U0rkCC
         WhTw==
X-Gm-Message-State: AOJu0YzX/h3H5BQMORMOArZH1qBV8ZbDGs1KW5CDDqCsb43VGjOIfDKu
	o1KF5Z7C3XcIOPQcnT8pIr/jdnyYv2pUU4Tp4iNae+dzM13D1kJYx/SNgcP5AmcKnVoFsxWiErf
	EnqaRCOv1vb6ipNTLhOg1CWhKSM6L4L32y500lw/lEA==
X-Gm-Gg: AZuq6aIQ6RcSzqyo8XF1c3k9rKt9U+RzYStafWXj5DrOGnxzVkhWAjj1oZGBHK6mmte
	iMNv6HnU+psMXtCnaqQnoFsWvSXR773Kcf15fz2aYd8KZ4yznk4JVu9J74OMaA1RbQPRveCfCEl
	pDh/L4nRx/ldzlvJZBK3Vdtwif6fhmMI8tvzrrwAZKQYELvHeE7vAZ6vYY5JywfGPUMx6JMfCcs
	Am/HQ6VvHZFLBE3R2g8U8DBvNoddgFUe9i71muG/NiXbpfdbTy7E/KznPNKZHlVrF4TEtJgLtLG
	ulcpSRK8IQbblqYJcDD761YOCdOMoT9a6N4gV66L3FyY6G9y60aAG/Pzyz4APB9jvkiZig==
X-Received: by 2002:a17:907:982:b0:b87:718:5da2 with SMTP id
 a640c23a62f3a-b904d615300mr1530766b.1.1771433331917; Wed, 18 Feb 2026
 08:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217200006.470920131@linuxfoundation.org>
In-Reply-To: <20260217200006.470920131@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 18 Feb 2026 22:18:15 +0530
X-Gm-Features: AaiRm50okWH3DSk3tmbkRt2VF_bXv0FImyY0cJg-Wxj8CuzWNmO5ZoVpgJfzAPM
Message-ID: <CAG=yYwn4ve1f9ydGK=azDkPFnnKiak5Wk391U3JhSgf1+Ukf1w@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/43] 6.18.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	TAGGED_FROM(0.00)[bounces-217311-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 531DC157DE7
X-Rspamd-Action: no action

 hello,

Compiled and booted  6.18.13-rc1+
No typical dmesg regressions.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology-

