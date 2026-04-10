Return-Path: <stable+bounces-235633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP1TNrsf2WkQmggAu9opvQ
	(envelope-from <stable+bounces-235633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:05:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EAC3DA0C0
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E4D3179EE1
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B24C3E6DEB;
	Fri, 10 Apr 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW30GnB3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1933DE420
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834982; cv=none; b=fd1kez+8CK7MyPeD+3NueL/o9G+6lOSTT81HLXeAqjmLUP+LplrwmCZk53jXnsIIPU30efSrHvD8uvXrG1ALW1BVGlAnDDQMagnxB3Jeov+TSQUhn75/q0TuI0CcvqBvW5ajzgL2GfpVfSPS+1fFMR5YikqTYBqDZkI2GH90H/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834982; c=relaxed/simple;
	bh=pMVJg16RiU5xetNeImXRVz5ocYzhoxQRKuIB3kbckjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxeBVuZD+ikdcMEDtigw0KJcYYQifiODP0S7M6f22+g+G0YMgEs/8DhKqjNlMqDIxTvBGNPc10/EVOpVnvCEDRSvDtejUcT+egwzsLjtHnmIjz/wn5nWXdY8XH/7WsMN6Ow0GqoGFCI8uRCt0JyZWl1/vAKLLe9czdqZDqYQrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW30GnB3; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so3621153eec.1
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775834980; x=1776439780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQBjqJfFbgAgcp+e3QnLHrvx3vq4o6Y5iRDazMhYwWM=;
        b=hW30GnB34mLaRyAS6fQWWiiIWJ1cotd0NphKa49gb90w90So57o6QB50a92dMTpoO3
         u9l0jLC0nBQneRX648/5oXbl4l9EDYlmlRpi/8Wr/IkaUzxH1wQ7CliJypp+iTq6TN/2
         mqBYu2wXMBC34NcDHzaydBQ56x/3IVBZZuiK+CnZz7UD1QcZU81zwu/Y/WOUWwIkgyRA
         tk/0E+HRK61Pgb82ZXTuh/tO0C/uj6rhxahSUw8JAOYPzf6lzxxK14UfzwIi5/MECSOT
         CzM5t+8iV/1gVgblVA5vcSkMAnvJzFyONIkMlYzGQkarZhqmQeHcK4ZDsMIiDfzQLqKl
         7/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775834980; x=1776439780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bQBjqJfFbgAgcp+e3QnLHrvx3vq4o6Y5iRDazMhYwWM=;
        b=nx0d2b3AjzA1VB8VWW7FUQSSAE4sKzsqRpC6V+9Z7zZ6WBn5nnnKX0xvPZB2hzWNsb
         MV+ukp4PsvT10HBDSc5M/qsy0edKD2jLHyJGTHjgXxSVZQEhPhp9/ZtePuyazovLJw0l
         J5mxpjnEOqnokdl1XfZOwyXpC1PhQPYfkOoO2OtvT/2mGlfGV9tmRTYVHOFIraDGCNIN
         m6nvxY1FL6BUvR6TFSW5o3k2nTKehlnzGBtHytvH2FzmuS2fiCjCuNSZvYssMlbxYxg/
         tSJR993naqvNnHGilTwYzkJEIfJh2ov+C/YyTlwqKCMXvjSUxYqVL1KFi7iazj4C+hce
         vYQA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Lk2Y6xAQB3LwQMB2AhSi6XJYzbN2QH+TxcJeElwUpi2PrATmP72DhORIlBw8dFCvnYfO9Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymrDkM1YWrbN4yLKA0VP0HGhlnT1+Jk8iIZeR5VDaimZhvQyYs
	qiK4h9YIEygHHfW+XJTiRh7HMevgyzUrcn81n7JGRYtWEAanLItHeQJoX+hdaA==
X-Gm-Gg: AeBDietGHCTwGG/1JVgALFisEBdhHnKbqM2Kra+061PnHZdbLfyJrMqJ1SCtPy20Kv7
	Y72s2QLDyIuOOsvMbkaKj6HVeWuM8De/j/JG/N8XI9ubZ0vPVnQVDsYai7ajBntC8iJUnijnnMM
	bJPrygUj5l/0J3CYNjup23PCvA9zlRvAiz1eQqU6xW+rr1oqF1Spt/bquBagSNj+biHTJ0CWoK7
	PWbOEw067+HJ6akRUyUkldotdWkM8rZ8rOOnwyIA8+fdHh0W006MeQ6Xpo1dv4zp+l1a0p0xgoT
	GUUlz4AdSlg8BYnLgtpgckff4QqrRcmBljNvA9VAxP3ydR/cgHNNufA4AsTpEiJ/x/HzRtxO532
	Tl7aHnn2NrarvoDTo6eYcP9Cusn2X72YxZwWfeyAEWgPJADCNw34NCxH/oHUjusMyt/W3LC8jkX
	YxwJVLQhR030SgP5aRTLL5QrfTCV69bm6ZKPjc
X-Received: by 2002:a05:7300:6da6:b0:2c7:8e1c:956a with SMTP id 5a478bee46e88-2d589662875mr2131999eec.19.1775834979965;
        Fri, 10 Apr 2026 08:29:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2c09sm5743556eec.18.2026.04.10.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:29:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 10 Apr 2026 08:29:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux@weissschuh.net" <linux@weissschuh.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] hwmon: (powerz) Fix missing usb_kill_urb() on
 signal interrupt
Message-ID: <de216660-de50-4a00-b244-c315ee040cc2@roeck-us.net>
References: <20260410002521.422645-1-sanman.pradhan@hpe.com>
 <20260410002521.422645-3-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410002521.422645-3-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235633-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: 58EAC3DA0C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 12:25:41AM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> wait_for_completion_interruptible_timeout() returns -ERESTARTSYS when
> interrupted. This needs to abort the URB and return an error. No data
> has been received from the device so any reads from the transfer
> buffer are invalid.
> 
> The original code tests !ret, which only catches the timeout case (0).
> On signal delivery (-ERESTARTSYS), !ret is false so the function skips
> usb_kill_urb() and falls through to read from the unfilled transfer
> buffer.
> 
> Fix by capturing the return value into a long (matching the function
> return type) and handling signal (negative) and timeout (zero) cases
> with separate checks that both call usb_kill_urb() before returning.
> 
> Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

