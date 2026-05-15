Return-Path: <stable+bounces-247758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIWUENsaB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:08:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D7550359
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFC643017060
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843CE2D780C;
	Fri, 15 May 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="MIhXrHo6"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04662D0C7E
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849948; cv=none; b=dG76iY5yYWIXMce/HETteb9ZJg1cj8T5gOliaeUncPXKX4oTd1wZ3eOApDvPOQqqKB5+ngNHnxLLbAVpRh2I75Ragw7BwmA5aEJKvLIgaBT2c3tTihQgrDE+Ewc1XMtCy5rgR4N7fcaD695QcYnFU6Dam5wAW/nRCjEZtjSL/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849948; c=relaxed/simple;
	bh=kUkexOW6ikD6ADJOKixIeG9VHxOgvgSyQYAqiA5UyU4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=crII2LCltWqrC3RzSWezDKqSpoQ+rB3Nkhfi8Kaai3TUQo0MuqXvSCutZPH0ONd+/KnsGLz0nFGuMQYR7IZTLio0JzKTyCWDmOgPZLiZMey7av0Ja2ijsah8boVNMQafmVFBw9MAOQOV1eDRPUfSf9yWOigWRgc1QcXJzxsctHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=MIhXrHo6; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-132830d8281so4838126c88.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778849946; x=1779454746; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzUcIu0j4wUFMAVPmUEoePJ0Rg5X3vE5XRSxIwlP//o=;
        b=MIhXrHo6EMrLtOZkx7fx9xKZNOAhKrjVOJyLt32CdkvSKQ3OhNBXGX/1GfVECf4Vvk
         XcwsIVFTF5gQWq/N9JGAXpb/hSlT+vUme87CtlPYjXUtpSJWUMtMHtuJzFuRntFPpziJ
         ActZgd3pNYlS5ofFiP5pMAMhRkfooNLz23tY8ZPWsUCo45uqE3cdlIn4cY2Gvis5o2wi
         ndnEiH0rePFVmmwcBglJ2r6ubapKM18lLH5FYO9EdXQoyuB5sNrvvbnRzeETHcT8T/Fi
         JBKm7S+OHaZEqjNbBrOROe3tBaugXLRv78eHMhjrTVf7rzewT44plbESvaDtRMy0Yr+k
         tXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849946; x=1779454746;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzUcIu0j4wUFMAVPmUEoePJ0Rg5X3vE5XRSxIwlP//o=;
        b=DxkL38xStiaZDdgDB6sRdQLecPOUp9auDbjlzeHwT2qoxbdECqWSJetmuNnb5KrVid
         XYd5ZtOtabMA3ws0M2Kz09jKOhVo4LTgWnHqRHcRZfw0lody5SzR2GXgz2jiwXwL27Te
         aSpE1rm4pQCWsh8JYh6P/KZTE+AasrmcqP/AxzGgo5/j09NHe98ZpBdfDhK/pFeYxkBA
         xN5J6+TsLoWq6grLZG9E+JFnQBApHnQbGG8K3r40MUKPMx8GxGLSRf4BthbvXcwU08ih
         gwZJANoH1D0QhJHxrFpZRhzP4QiiJ1D9Pl6AvLHrl4TQeyBkNccn5bZ8AsJNTPHM1qRo
         O1Pw==
X-Forwarded-Encrypted: i=1; AFNElJ8KQuPwdPPC51vheexjL3k3NzAOrWeGIE1aE929d95rBy0DTAQDnuPMt+3lBjEwg0g3YWD/Qms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DLBy67fQQLMjPhZikdYrTaRhBswNRcc4IKYUqrrrwurb3yqv
	l3/p/OOHcxUIwoQx6a43cquxU6qkG7ZnrVADJCQPi/Pp3l5CKufM9wXOO3kz+YH339iZVBXAFqA
	uPbWV
X-Gm-Gg: Acq92OFSnZOE8IW/5le312ov1nc723oi/2GkevY6uU2w8nnkrVOC/eRgj36agWkxY17
	kPoLwUdQkZMWB7uDA7XLosTfy1rxDM2oEAP6uwihJuIM8fQ+3uCwMIhaQ912LM9TQUd+lCxmlBu
	YAkOgUr0aAUHeOvyTH/s+sWaVccHTvd5tTIh83bKIO/yXfFAZyHEkPrwn7Dol1VA5WsajazOlMs
	RYoMxasQGUa9OBSPscceUnE9Wi1g/b0ucFnMyNHyouM43SLbSPOP2XwbQTN//DRTVk00Kv3EDda
	o5jQx1lGecoFl5qIgRl54nT7Ri9pJhWBNHv6mbbIAyhHuFs82doySjGrizS2w7kYAxcvq09MtiQ
	Rzsvaabr2TtfBIVckjbNvCwCIj8+OesMs9kbzpaHMq2rGkQbrEBq6Cp1hCjLe8AC89bJPpWSqu3
	Ui3weuW/8swPRdd/zwFrFnVgP+7EM=
X-Received: by 2002:a05:7022:1a81:b0:130:6c8f:5a9e with SMTP id a92af1059eb24-13504c5e53cmr1708476c88.15.1778849945540;
        Fri, 15 May 2026 05:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351c3sm9920917c88.11.2026.05.15.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-7.0.y: (build) format specifies type
 'long' but
 the argument has type 'size_t' (a...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 12:59:04 -0000
Message-ID: <177884994442.966.9450941034829662112@330cfa3079ca>
X-Rspamd-Queue-Id: 996D7550359
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-247758-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-7.0.y:

---
 format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat] in drivers/hid/hid-core.o (drivers/hid/hid-core.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:f8dcc036fc4c3d2f25a3201226ab4a04861af094
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c3ac660c0025a522fe38f2a7bcc3c919aa8fc96d


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/drivers/hid/hid-core.c:2050:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
 2049 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
      |                                                                                         ~~~
      |                                                                                         %zu
 2050 |                                      report->id, csize, bsize);
      |                                                         ^~~~~
/tmp/kci/linux/include/linux/hid.h:1310:43: note: expanded from macro 'hid_warn_ratelimited'
 1310 |         dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
      |                                           ~~~    ^~~~~~~~~~~
/tmp/kci/linux/include/linux/dev_printk.h:227:46: note: expanded from macro 'dev_warn_ratelimited'
  227 |         dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
      |                                              ~~~    ^~~~~~~~~~~
/tmp/kci/linux/include/linux/dev_printk.h:215:25: note: expanded from macro 'dev_level_ratelimited'
  215 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
      |                                ~~~    ^~~~~~~~~~~
/tmp/kci/linux/include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
  156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                                                                     ~~~     ^~~~~~~~~~~
/tmp/kci/linux/include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
      |                              ~~~    ^~~~~~~~~~~
/tmp/kci/linux/drivers/hid/hid-core.c:2072:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
 2071 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
      |                                                                                          ~~~
      |                                                                                          %zu
 2072 |                                      report->id, rsize, bsize);
      |                                                         ^~~~~
/tmp/kci/linux/include/linux/hid.h:1310:43: note: expanded from macro 'hid_warn_ratelimited'
 1310 |         dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
      |                                           ~~~    ^~~~~~~~~~~
/tmp/kci/linux/include/linux/dev_printk.h:227:46: note: expanded from macro 'dev_warn_ratelimited'
  227 |         dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
      |                                              ~~~    ^~~~~~~~~~~
/tmp/kci/linux/include/linux/dev_printk.h:215:25: note: expanded from macro 'dev_level_ratelimited'
  215 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
      |                                ~~~    ^~~~~~~~~~~
/tmp/kci/linux/include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
  156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                                                                     ~~~     ^~~~~~~~~~~
/tmp/kci/linux/include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
      |                              ~~~    ^~~~~~~~~~~
2 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a06f8db0ed99f002e8c2f36


#kernelci issue maestro:f8dcc036fc4c3d2f25a3201226ab4a04861af094

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

