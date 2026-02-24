Return-Path: <stable+bounces-217909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCuFLJaanWnwQgQAu9opvQ
	(envelope-from <stable+bounces-217909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:33:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 547C618701C
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF20F30B1039
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC27C3803DB;
	Tue, 24 Feb 2026 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UppypOhV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8s0S56j"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057C1E520A
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936283; cv=none; b=rPP2tNDMe4XncAhnO58cjoS3KCRoAE3Sq8aEYy3C+MbC5Ql0LwafW4ky1u4D3hl74zeZdqdEJ1x1GersVXqWAk+In90MP9e0QGtH231YT5I2Hmw68kV2iLRug9MuMbJIog2sV20C+WnvQTJrr7DkZDyf0wONFTzls/b3y0hT7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936283; c=relaxed/simple;
	bh=SamjuEziHX892HncYad7CyUVAA8BuQMJx/u5koX1Op4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7HQdP5p3+q1TxYlenbea61ly1aOyjP3oOu+nU6Vr4LX2KOvFn90A3lbNIcftcJJWp5dO6VM+GfFlB+g+ZMYix3yysrb+Ks/40AX+LvKxS1+DbEdqIuQxzk1HJm0w3SPVYzuh2jvN9U+kbM/Tb3iZxQxXhnu6zw2lg0DtJbBx10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UppypOhV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8s0S56j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771936281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ye5BSedqBSPKB63d7KAWCVrpAPKOLkf+I5Wqz9mFuD4=;
	b=UppypOhVDqbzOvRLq4Tp9JpM9B9BXM0a93hrpwlMsdN8WbD/VcAXvWmadEbc2gKji1M2nj
	apayjKD9teKTgFjmY9uTcfoNsV1bvXM6XcPPJMgriQlkmwinilSFh5MNB5E5qpbYi+BK4t
	HBDguk1AFrctj/MJf2zeNV4huOmYffo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-17mEwnTLP8OEDkWZSHK92Q-1; Tue, 24 Feb 2026 07:31:20 -0500
X-MC-Unique: 17mEwnTLP8OEDkWZSHK92Q-1
X-Mimecast-MFC-AGG-ID: 17mEwnTLP8OEDkWZSHK92Q_1771936279
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837b9913c9so53377625e9.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 04:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771936279; x=1772541079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ye5BSedqBSPKB63d7KAWCVrpAPKOLkf+I5Wqz9mFuD4=;
        b=Z8s0S56jzTD0q2/EbaeUclvZ0Bxny5hMnNuVd3JBTPt/T8Tq6E/PsvN6PPLprxzAYW
         uLbcGlegIraAIf3obvqWghLTj/RKXuKXeBRNH4ZCbgiPMl7ufQISKIGGfa+j0AVYShmF
         TTe4Yugfbt12HffkPozSRPMizUpZCzzSteHP78boGe6zsF7mmNLC78KIjwIov6eGMMeU
         sHNahXuyqIx1HhdBXjGzUVSx5BgtQifpBuRA1MMxlTFLirHHV8WjQECiJcrRXsNgHjDy
         iVybWrWryjIAX6pGb5wu5Boght8HMXNbHGCqAYKZJAUYTHg4wKkIjQTz5lj5TjOWIeX1
         OUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771936279; x=1772541079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ye5BSedqBSPKB63d7KAWCVrpAPKOLkf+I5Wqz9mFuD4=;
        b=mkj3CtSvu6HR2It8XLJR+V/2Ih1l4l+j1XBTJ/36OZNqVKq5Rolsp6nX9TMEZbsOqu
         eVseHPUQJIfL8AiFXoJGdv25EYltnoeRh8j4EBsdQNYfLrPiZtA/B5Q6wMxBnz1u0kEj
         0lMSx+I466jUniV0DqDpuynmMgJY7xEs1mcpAZbfbVXqi90xbdcZlQcMVY6MXnSdUDs5
         OgtpeoJ8YE5fgMHcVdRSz4mk1VHmAKdwGEedtjQRMj8ezMsjh4sZC7Xp2/UfJP4CMuvF
         vlyGR5Cy2TnjeAJ0m7jhnktKCylUyJ8IF14Kbh9Wh0lj6rS0kQpf49wdU9MeoWO4WWdE
         2MDg==
X-Gm-Message-State: AOJu0YzNUjqUHm8Qtj6nOpvY0P/yvTiH7n1+d+qV+v4j9XfgPTcl7FUX
	Qwb1YgMvWDS7sNxLYrx75jL02ss1tnh+SOjHaDE4d3ay7Xs+dxpWgVXG5uv3jrykUUwOlej0YnT
	rRRH5RRdbwNcDVDm9xdX9cCvT43d4ncift/n17BCGKr2KvMRs4bRPptwlvg==
X-Gm-Gg: AZuq6aJFvQdQgy3XO6mYa2P75nVLpV4/g0oexFmGh/5h6Ubc4U8BIWwFEDea7Fg4IF1
	7A3e/1zpiHNqPA4yHNpAVJhqawoqA/g3svHwPz0iG59g5vnp9SoeqCXUadULc/dLZypKkCy7Eq/
	gN/v8trGW92Blo2Iq63pB7o76ZOFgJhjQhJHSkaCYs+vK4LJP5WTjj3h/2uvsjxL+8eHYPvWd2A
	vWIm57A2o7qgj/vIHampC9aHQf8r/k4yMNcBrx2eLhmbfxb0wu+V/ZfT4H5741ptGMWdIKmjfxl
	T8EEAxOSuiJ3wC9IlvpWrkcPKr4x5csnJUX6fyiVf5iHl500FOgzDTNlyfbVLcCUIq59mpl2hYu
	YL3Y6Ev4Vz2mG0yNnv73w
X-Received: by 2002:a05:600c:3e10:b0:480:5951:fc1e with SMTP id 5b1f17b1804b1-483a95bd836mr211810975e9.11.1771936278991;
        Tue, 24 Feb 2026 04:31:18 -0800 (PST)
X-Received: by 2002:a05:600c:3e10:b0:480:5951:fc1e with SMTP id 5b1f17b1804b1-483a95bd836mr211810365e9.11.1771936278451;
        Tue, 24 Feb 2026 04:31:18 -0800 (PST)
Received: from [192.168.88.32] ([216.128.9.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b81fbeb4sm42418575e9.1.2026.02.24.04.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:31:17 -0800 (PST)
Message-ID: <d60bc526-fb21-46c6-916e-b063c959259e@redhat.com>
Date: Tue, 24 Feb 2026 13:31:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nfc: nxp-nci: allow GPIOs to sleep
To: Ian Ray <ian.ray@gehealthcare.com>, Samuel Ortiz <sameo@linux.intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= <clement.perrochaud@nxp.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260223070533.106625-1-ian.ray@gehealthcare.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260223070533.106625-1-ian.ray@gehealthcare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217909-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gehealthcare.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 547C618701C
X-Rspamd-Action: no action

On 2/23/26 8:05 AM, Ian Ray wrote:
> Allow the firmware and enable GPIOs to sleep.
> 
> This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
> connected to I2C GPIO expanders.
> 
> -- >8 --
> kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
> -- >8 --
> 
> Fixes: 6be88670fc59 ("NFC: nxp-nci_i2c: Add I2C support to NXP NCI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>

When resubmitting with the correct fixes tag, please additionally
include the target tree in the subj prefix (in this case 'net').

Thanks,

Paolo


