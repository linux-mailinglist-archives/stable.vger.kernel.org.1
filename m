Return-Path: <stable+bounces-214751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFZoJhzOhmkRRAQAu9opvQ
	(envelope-from <stable+bounces-214751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 06:31:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4563B10506E
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 06:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC04630247DA
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 05:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003F950276;
	Sat,  7 Feb 2026 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbeFA12x"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD7256C6C
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770442263; cv=none; b=am1MgZTmtylG1oLZNCBYTNWQui+w6Z2v+ypL+OtcK2yuUJ1VsXOBTU8ReGo3zvl6+5NrKiQkNSoGJDjaCYMr9abo2b3I+5nH7fTCACVHSGH3q3T808pnisCNmeTkOYbf4mAo48KXrvRpHLtIwZro1Eyc0U5sfopGca80AYvaIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770442263; c=relaxed/simple;
	bh=6CMcImivz+9TGRX6cDLBO8eka/508xuj+j3Oja7JGm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX9bL1zJEA+UvGkAub/6ykzHOeL1ci/IiFj1qND3wCjk+JBgRqu6QqkncwEmisbPBQVsjh3JQiwMiYFUILOHF6oZPWFecvQ708ho08CXsBeMQepMUxfMG9b5z9ZMd0zfgkhNB7fQL7og0v/yAuX82ibdp6kj0AkSri7ciQeTXhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbeFA12x; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d67f1877so8648985ad.2
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 21:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770442263; x=1771047063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r1/bFgz7fHK5C32YZ4rSXfMrTJXSkBGVxxwZofFjNE=;
        b=WbeFA12xzJuk376PJZiXUbBxj3q4SsX5K4+QwxVDAomx05MQgsnby172h91hcuUfLV
         NVvVky9zL+ugNcK2x+F3+7NTEsbymg5bRLirF18gCuscXZusUCNRAbrGv0ICVhPxBuza
         wYql06qaBmonB735k4QT8N3BBSPsL7t9iIB2t856K+ckoA0Ir5cYTx7P09NaCcgMH28k
         EOmIf5wbFcreXagevUeTrypxW1v7a2b/HGPDhnwWsQBvAx5d9d7n/1SRWbrbM8bAn3Gg
         Lek7CT7Sxq5Wl47rVVfvpxwu/vdkXlG0MpQ5sDBTiURB6p4QsCj0WVLPaGH78EWVDsd5
         ZwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770442263; x=1771047063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4r1/bFgz7fHK5C32YZ4rSXfMrTJXSkBGVxxwZofFjNE=;
        b=LRnWcg7vKd804LJ6TjhSKzhThZ+8hJ5iLbn3yJFo8UVAcEVwZHsKTVXZbcGVw4o/BM
         sXhEmmkd8xC19FaUhQRSPjvmK43rJwoCEpo12o52BZzIvnEy0kGBiovXNd4JpUDU4anp
         bS7/YC4rpmgU4Q1B4/Z68kk2RVfrUSw417TgaBdvWB1WTx3ZOh4IlNH4XvBGIXhNZRIL
         uyb7NzQa6p1nb4aIdjfGhs96IEyRR3Rj/D5rx8g7P9oarVWIOiPoN62h1RbgLt6sdtur
         4SONhrsi+AbiYpOkd7Hmoki9H5cp0UCccNQEFpPU+06RyhPV6UjL6YIuKej4sr/m2dbt
         P5uw==
X-Forwarded-Encrypted: i=1; AJvYcCVrVwbb7VOSuzw0TFCc+OdtsaJ4sVG61GAyjzDsPalAs5WK93nbptWs7pwFkHUbZhfTqd30Tz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymMLTg0wJbRRfpNqGA8gsI2hP4umiXmnD9G84GcHMx6zKUhgHu
	u+ZqfUkWYKv3akemuKiDVmuh98PbBB5E2SE00wkXifgAOyyFpOfIVtKS
X-Gm-Gg: AZuq6aI3VTUhDda3Ki5E9ts2Ca/sGqGLtPIFetd4lzA/Jzn5lSN9kGuetEuaiyKC/EB
	qDXLr3ZsV5fHUJuNiawmJiE58uUNog4X4Dw2uK2UsErZOWRu6tgfFTtVFBgnmS8gLg5qjkUr6HF
	xGm7/v57qOjjfCTaymBNk7h9ahxa0ZIMM8Xr0uOQkW582FpIHWnkC+P2P9G9RZpVW+0B9yvtszD
	blxh7YhGtvTfOzq8DlGESKVW/8tI1jM1NdNMaHddSpbkUZH8n5rmElNV0YsBxFCCxrOEt1Dzj1s
	C78/yKqO8dpIgYWdZ0Y8n4hSnydhhq0QAkpXCgzkjQbOiGNVhm3pdnELiIs+nXWodOLS6ONq7DV
	sFhQTW8g+d4ms1vLBZIGQGu03QEzbZ3HsdJNSKI2Z+iugHqAsisoOE6agOPLZAQbCkCZBNO7Qlv
	A+eILe3NN1YoysGbPW3cWowcZ3n3KUqwKsRJtd
X-Received: by 2002:a17:902:cf07:b0:295:5dbe:f629 with SMTP id d9443c01a7336-2a951608c6bmr47072025ad.8.1770442262725;
        Fri, 06 Feb 2026 21:31:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a96251b6edsm10731145ad.69.2026.02.06.21.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 21:31:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 6 Feb 2026 21:31:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, Ben Hutchings <ben@decadent.org.uk>,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max16065) Use READ/WRITE_ONCE to avoid compiler
 optimization induced race
Message-ID: <3d81c0ff-bd80-4b06-9a59-545b5d94e6a4@roeck-us.net>
References: <20260203121443.5482-1-hanguidong02@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203121443.5482-1-hanguidong02@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214751-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,decadent.org.uk];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,decadent.org.uk:email]
X-Rspamd-Queue-Id: 4563B10506E
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 08:14:43PM +0800, Gui-Dong Han wrote:
> Simply copying shared data to a local variable cannot prevent data
> races. The compiler is allowed to optimize away the local copy and
> re-read the shared memory, causing a Time-of-Check Time-of-Use (TOCTOU)
> issue if the data changes between the check and the usage.
> 
> To enforce the use of the local variable, use READ_ONCE() when reading
> the shared data and WRITE_ONCE() when updating it. Apply these macros to
> the three identified locations (curr_sense, adc, and fault) where local
> variables are used for error validation, ensuring the value remains
> consistent.
> 
> Reported-by: Ben Hutchings <ben@decadent.org.uk>
> Closes: https://lore.kernel.org/all/6fe17868327207e8b850cf9f88b7dc58b2021f73.camel@decadent.org.uk/
> Fixes: f5bae2642e3d ("hwmon: Driver for MAX16065 System Manager and compatibles")
> Fixes: b8d5acdcf525 ("hwmon: (max16065) Use local variable to avoid TOCTOU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>

I don't claim to be an expert in this area, so I ran the patch through
an AI review and asked it if it is both necessary and complete. It claims
that this is the case, so I am going to apply this patch.

For those interested, I attached the AI review results below.

Thanks,
Guenter

---
[AI generated]
Summary:
  The patch addresses a theoretical data race and TOCTOU (Time-of-Check
  Time-of-Use) issue where compiler optimizations could reload shared data
  (data->adc, data->curr_sense, data->fault) after a validity check but
  before usage. By employing READ_ONCE in the reader functions
  (max16065_alarm_show, max16065_input_show, max16065_current_show) and
  WRITE_ONCE in the updater (max16065_update_device), the change ensures
  that the compiler treats these accesses as volatile, preventing reloads
  and ensuring that the value checked is the same as the value used.
  The logic correctly handles the "lockless reader / locked updater"
  pattern common in hwmon drivers.

  Verification:
   * Concurrency: The max16065_update_device function holds data->update_lock
     during updates, ensuring only one thread updates the cache. The
     READ_ONCE/WRITE_ONCE macros correctly protect against compiler
     tearing/reordering for the readers that run outside this lock.
   * Error Handling: Error codes from i2c_smbus_read_byte_data and
     max16065_read_adc are correctly stored in the data structure and
     checked in the show functions (via unlikely(val < 0)).
   * Code Style: The changes follow kernel coding style and best practices
     for concurrency annotations.
   * Regressions: No regressions were found.

  False Positives Eliminated:
   * Self-read in `max16065_update_device`: The line WRITE_ONCE(data->fault[0],
     data->fault[0] | data->fault[1]); reads data->fault[0] without READ_ONCE.
     This is safe because max16065_update_device holds the update_lock,
     so no other thread can be modifying data->fault concurrently.

