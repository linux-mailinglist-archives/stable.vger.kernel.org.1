Return-Path: <stable+bounces-251069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOF5NXfuDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-251069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:25:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E4F593995
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E29B30CB53A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951F3F076F;
	Wed, 20 May 2026 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="kgOTCnr4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A03A7850
	for <stable@vger.kernel.org>; Wed, 20 May 2026 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297019; cv=none; b=NPR+JDPAhyoPe/RvIUwjPAn2ft9xoJx7ROfhZAI+3hlO1pt0HOE39gsrdDxqoRcYMr7JTcZ5vq5NMLCSRilk7tNkjh3Yt/wBCLvsqI4duJKSCPavc7adiexb5THe38ymU6y2HRzZBYt/zqzmzOIn0K17Plfn2ONvmsncSf3kxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297019; c=relaxed/simple;
	bh=WRjV1fblvYAQ22vZ0eqwhU4cl3qJbPBDiN5/spvOquc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=ZNiBaQNFzTBYe3xYIiI2Y7MEmJl6hKjd7JhMA6KEf+RyhIKWVaoZnqbp2tmE0uZnbVDzFIkUnn5Sn07JsbAHqjfWlAE9mnshBj0sD6gqi8tEARmm1RBLK+fROXrML5/pZlgGLE/d7E7Knzu9RpZWCnxhJaoIzwTQkSKLEMJoiAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=kgOTCnr4; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1357c851a48so5574983c88.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779297017; x=1779901817; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRjV1fblvYAQ22vZ0eqwhU4cl3qJbPBDiN5/spvOquc=;
        b=kgOTCnr4iddIuKdp+BhE9fK9Mt2bZ3S3aRzEufl6VclCT6WQtDrrHJfXV4ylSnT/DP
         p2tClAHROUpnRwN2haiaCqw+Z6RELm3JvNYSD/X96OOPV3//cYAfxYFbjb1anueF55d9
         /4x9oyv5mAMU7NG0lN/mhqcpIkjiJNZCPd3iUsB0bLVv2Rhw8XdsstEGPgRwwHCTMxaQ
         MF5IwEaekIEZbTBawcb2d3f3iuciQYU489ZUNWyNUWg0Ez5PeIRSGjd42jxUQdX10Hso
         PLZZv0U2C91V+3R4gyRlfp0Ziu/jF4jokg1K/X+TO662jk53gvw3g0gurppH+E7989Su
         kSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297017; x=1779901817;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WRjV1fblvYAQ22vZ0eqwhU4cl3qJbPBDiN5/spvOquc=;
        b=Ww1CPnt3EvasBWpmCkPs5Jns+mLnSuaRXn8ABZbeudlb22rTD3o16OvmZ2Zr2Ymyg7
         T3KNcpMOUT02+SUy7ggcMrTrk1n1Ey2bLW1BTtIfBUypFC7yHQatf4aysM6B4pkGrPES
         L7ZserkIg5FnjfPlozyipw5Y0hOXfV9d3KhLGhy3yxRyS0cnRoNUZCjL58XPI5oWRPFR
         XNvNJ4z5i5NxamRAuVpyaTAQWFeVb5TM0BQWfLrqyLWPZUHMjuH1LtZMaEIoM3Advunf
         zZup42ZpEg0De9Fu0wIhg4EmLryxX3Q8lLP1p7Ed1VHoG0id+w2h5rN/w3BDtY6UbKiZ
         Yi0g==
X-Forwarded-Encrypted: i=1; AFNElJ9wg7NJrz3hkAChgOKh3WM/Jjnj5q9AttxiN+jm3FYY/vCbVXHHvm8lEhOYh4ZTkFLglknMxyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1K3xZZUe71H+rfIClfNdKCALheyZoWDo409fTidWCC+oqYYno
	Y9dAoG3qaYhhMUsFglshp7rlVkXcK991OV8OmtzdMarEKvkaeFj1Ff4GpeLuZWI+gmtXnKFTtwX
	aDhB3Kq4=
X-Gm-Gg: Acq92OHa2qYUJKEJSGoOmpJ96IND3sJM+eyYI3m4YjdNCf8T1k8RNMF7mnme5CWt9Vh
	miUa6XRB9KfvZkulfnPFMVXZceP3wtkSFYybhD7etkk3tTcdsSNxfV+5+SgR7gTTwL+3+VItI+b
	a8oCr2bu44AmyabiZE6mzhs/vMevAbeaS+86VHXo+wBXV7MGYUEOOT/XikuMYT6ecdaGjavvTGC
	o3ein162WJY2FXHxO3elRPM7Q987atGXBGKX1XxwvGK3qC6ko2YuCfthy+2LDG4undQoL4LZUO2
	mBmPqhKAIwMaMgiO5d7Wz3EJAep3orMYOlaisjnowfRfFdMFzPqOU+/vrFYEQqEdRHNUBx7rPV0
	Aq167O96heTTG879nhUUJhDvA2uC+eMDzu2jtkUv+W7gIBZ8Wqmcigfqn9r6T7Rvqg3FS5WRJ+Q
	/LaLOgMs01gT0cCeGr8ZtOYzo=
X-Received: by 2002:a05:7022:40d:b0:135:31e7:4e62 with SMTP id a92af1059eb24-13531e75045mr8225611c88.13.1779297016998;
        Wed, 20 May 2026 10:10:16 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm26085229c88.2.2026.05.20.10.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 10:10:16 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 10:10:15 -0700
Message-Id: <DINO5GQHP6VK.ZBC2D5ENBYKW@nexthop.ai>
Cc: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Guenter Roeck" <groeck7@gmail.com>
Subject: Re: [PATCH v4 0/3] hwmon: (pmbus/adm1266) add clear_blackbox and
 powerup_counter debugfs entries
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Guenter Roeck" <linux@roeck-us.net>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>, "Alexandru Tachici"
 <alexandru.tachici@analog.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260516-adm1266-v4-0-1f8df4797258@nexthop.ai>
 <da0fbce2-788e-4419-8ca1-975311951ce3@roeck-us.net>
In-Reply-To: <da0fbce2-788e-4419-8ca1-975311951ce3@roeck-us.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251069-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 52E4F593995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed May 20, 2026 at 7:10 AM PDT, Guenter Roeck wrote:
> Hi,
>
> On 5/16/26 18:18, Abdurrahman Hussain wrote:
>> This is what remains of the v3 series after Guenter applied patches
>> 1/5 (firmware_revision) and 5/5 (GPIO line label) to hwmon-next, and
>> asked for patch 4/5 (rtc_class) to be dropped.
>>=20
>> Patch 1 adds a write-only clear_blackbox debugfs file. Devices
>> configured for single-recording mode (BLACKBOX_CONFIG[0] =3D 0) need
>> an explicit clear once the 32-record buffer fills; the documented
>> sub-command ({0xFE, 0x00} block-write to 0xDE) wasn't reachable
>> from userspace. The patch also acquires pmbus_lock at the
>> adm1266_nvmem_read() callback boundary so the memset of
>> data->dev_mem, the blackbox refill, and the memcpy to userspace run
>> as a single critical section -- the nvmem core does not serialize
>> concurrent reg_read calls.
>>=20
>> Patch 2 exposes the non-volatile POWERUP_COUNTER (0xE4) via debugfs.
>> The same value is embedded in every blackbox record, so the live
>> value lets userspace match a captured record back to the boot it
>> came from when correlating logs. The block-read is taken under
>> pmbus_lock to serialise against any pmbus_core PAGE+register
>> sequence on the device.
>>=20
>> Patch 3 takes pmbus_lock in adm1266_state_read() (the pre-existing
>> sequencer_state debugfs handler) for the same defensive-locking
>> reason that motivates the new debugfs files in patches 1 and 2:
>> any direct device access from outside pmbus_core should be ordered
>> with respect to pmbus_core's own PAGE+register sequences.
>>=20
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>
> The series no longer applies after applying the bug fix series.
> Please rebase it on top of the hwmon-next branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> and resubmit.
>
> Sorry for the trouble, and thanks a lot for fixing all the problems
> with the driver.
>
> Guenter

Will do, thank you for your support!

Abdurrahman


