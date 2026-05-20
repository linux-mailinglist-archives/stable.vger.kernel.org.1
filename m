Return-Path: <stable+bounces-252930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Hf1FyMZDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-252930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:27:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C07459999B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26C02325F2F9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E84917A2FC;
	Wed, 20 May 2026 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKH5my4X"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9A33CEA2
	for <stable@vger.kernel.org>; Wed, 20 May 2026 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301960; cv=pass; b=AC6/84CvE2tA/pwEfo6zmOqOIKsjZyJOKZVXPc3trLqtOycAtkBedG8koFYhihcSXxi46AWwgr3K7BTMRDb45GX+CX8SThFWQF/Bz/6KWZS2KANy/fibiPjtbOuDD8sKT8FTJ24WjX5MqBlIQnWkpWSAGodESVdy2NeJVtF7wls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301960; c=relaxed/simple;
	bh=Iyx8dnBn0kYwBZ0SP5ro0ffqifZw18RfJZjsNcvONIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9pHlx1qWmQPicMhy5ASEv6LTbq8mZQaz8t3Vl9Ay9mdRQRQsUtLLyVkqV5h0wNK1erIA095G9cIoEmDo1izuCHod3zMmStnQ6v7UdlKaA+iflCKXrnb1LYHvsQZ0UPAFWdGxz4PhI9b37IzSSiTquk4FNmMCN3plO8SlBKBH0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKH5my4X; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1334825de43so4898577c88.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 11:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779301959; cv=none;
        d=google.com; s=arc-20240605;
        b=gx98fIA7l7Tkzb+RkNuwR3wvUkBVA9CJYTkPrcEgfTFrWh/yOeqN91A3aThTHCHKhC
         RTSuHxwZZ7y13uXEPrSMTXsfjBpqJB3L2oPaWYaEALGKMwyLXG/iN9w7B3zzeVmrChfS
         yJRcjjlVb5GebAGbU+TW4UTqNF+6eUH5d3TIevyTDiygot94rcjyESRN6Y2spdhV0Nwt
         P3ltNQYRJOiFQWhUC+Ghcd7pDAtLIrcDEzdchz0iNhOjHxkkHV9hm8xyhTAZ6oZhjnX/
         wmDMUW5b+rECQhYJuOWIMyHGT/mdmqitjqIypYfJlyz2lyRLRPdflej+d3eOXfV5U4Ip
         H+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YcognBcrpWvnvJQi1n7S900RyaKYlaiNOYb48LzSaSo=;
        fh=UxLuhZUoiR3gjmiEAEA4o4o4pC5RrTR6T85KmFy1hlE=;
        b=XyOIt98wlkFQY57oe40/qgB/S+2Ig6tLZvag92YF4Bpmdq8U6rA35459epVv6YvtQ4
         Ac5/s701E0zCPip7hvgwBmtYw7JNBgmJaXeOAynKkGEPETfaS6dHTTcmMvnQarQNIzLi
         H9b5S7OXual9XMunEm9ktcMmQTU7D0F3QoNgX1+4ugjM3UJL8QxpJ7hwiimJVIBx6hYm
         vtxwASv/oGBOY6Jbv+gbW6m7yts5gr+OLInEWFqYw/QpZGQ1YOUaE9Q19nQgEOv+ZXFp
         T6dcCp9psicOpbuwrKzY7gymKRNBEcKjHyqU1WRkZ/3c6KeZzoVEsDPGSdDujSZb/m21
         RHNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779301959; x=1779906759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcognBcrpWvnvJQi1n7S900RyaKYlaiNOYb48LzSaSo=;
        b=GKH5my4XxoaUPmAxEOWVfEuHeBLOwnpPo2pz7uu/AdqtDE0PK37lWyBHVw3YEu5GQE
         f4ufMoi06f9TWQ0+QYShtyuu5JBN8f0sZ8zX+UROHSREJ6j481X8BSzM3Bw2SorUAAL/
         2sykM3uIImFEp6bXykDQBv9RCWU+kYTOy+yVTvv2Kt/xHIp2WfiGEDizkaVBxcmwMJMX
         wEs7PqU9x19vlh+BL5bSQW1ZaZk5QCVqvZSC1ur4JkRV2MwBPfHbrYWfUt3033NKQeM9
         9/Y9q1eTMJhSp5KCMmbb2gr0Aprwkwtos7AalxzDJ19ZbObJLuw4seJRZ4PYVxc4Lf6m
         CL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779301959; x=1779906759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YcognBcrpWvnvJQi1n7S900RyaKYlaiNOYb48LzSaSo=;
        b=DDZEp5P18M4WBiEbmf5oqgWN/v9IFJWicPC2/Cei5a9K2qR01Tcc6E4La16bhhWLe/
         h4ZxDRc1yoXsVrccYgVdyQVortP+IbNPF5OFHcvslkIRs0PSmQJ6jb3+/RnKd+96XbJj
         a9vz3OPWPZx6Ix6uQavR/3kEI5RYMAkQMN3BZR7C3Na7GZkyC3EJz2+FZWTmmkDpWzOT
         muAPv3wN0lGaRDAHFtBBeP0OIKBCteo7bLUS8rfDqSF453onNctwQ3rHB1xYIB8e31EN
         57pJV6S837n8TvvWjhepgoKYnRkghzmkcHJVxHYXlZR1cQeo13OoWHSNJtKl/iwgjYI+
         QAVQ==
X-Gm-Message-State: AOJu0Yxj3qmenEyUxBNgHB70UT1xeY2nt3kJBiP7XBl/kOI8a5z2XVB3
	rlKjcWHgbZ5XYpVpQyd6B6V59DJ6ru/JSIFm4Lsomdkc2KKgkTHrng39l5mG/L1L/+kJHoyHMVA
	MMYx7nSUT3D9/hw1GJd/FE5XGe+xIh5Ol8fMkWao=
X-Gm-Gg: Acq92OE6QvuCEqBqfeKNuuQgj9jvGSeGMPLmeBDR+c4Mo0WHWOoXenw5wBU/yZFJCzU
	Iz6c4uyaugB5CmU7Ug8SYdIKpZY2xKgIWzhg01BGzhfFC8pQa/NZ8StFolfkAFcXNkIlWsh22/I
	tfJuhc3eM9sYVC9vcZ37JCuIjly6UuMg00kWDR8wrIPOqUPwHl+GrR2+6rdRo8BafezCQdAxbPD
	HPwpwtEWyHCiIBmYdOMMs+0kTa77N8MGCv0TeTQKPZSfC/Z6kgRSK6BLbqvKHfGFCnzgbrCQtC+
	+vHwGeENV+1j2xi6D9W4OEUIddUaKlnCEj8kSy8vNULBpCUEv6iQG8rzhLD2nFZXVXPHLTLghkZ
	Yw2OJRT/9CojITmGTwOri3G1+JUcnj/Icj3bybkLTFMicUA==
X-Received: by 2002:a05:7022:fb09:b0:134:def6:e73f with SMTP id
 a92af1059eb24-13505433a9fmr9856930c88.21.1779301958047; Wed, 20 May 2026
 11:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162134.554764788@linuxfoundation.org> <20260520162135.687777470@linuxfoundation.org>
In-Reply-To: <20260520162135.687777470@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Wed, 20 May 2026 11:32:26 -0700
X-Gm-Features: AVHnY4Kgob_5L6wVdbe5hNklqyGV6AbNPh2DYL9FVbYHSV_a8rpBk1d5OS6HIcU
Message-ID: <CANDhNCpZWMk6GWubK8+E0rxKUqtuhOtrjqxunS=Kmho-UbR0UA@mail.gmail.com>
Subject: Re: [PATCH 6.18 052/957] sched: Make class_schedulers avoid pushing
 current, and get rid of proxy_tag_curr()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252930-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jstultz@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C07459999B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 10:18=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.18-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: John Stultz <jstultz@google.com>
>
> [ Upstream commit e0ca8991b2de6c9dfe6fcd8a0364951b2bd56797 ]
>
> With proxy-execution, the scheduler selects the donor, but for
> blocked donors, we end up running the lock owner.

Eh, I'm not sure of the urgency of this going back to 6.18-stable, and
I'm not sure its worth the churn.

Proxy-exec is still in development and requires CONFIG_EXPERT to be
enabled, so I'm not sure how many folks are actively using it with
vanilla 6.18-stable, as it wouldn't bring much benefit, and even if
folks are experimenting, the downside of not ideally balancing tasks
isn't likely to cause a crash, just not ideal performance.

And I've already pulled this change back to android17-6.18 where we
are using the full proxy-exec series,  where the actual usage of
proxy-exec is likely to be.  So I'm just not sure this is worth the
churn/risk.

thanks
-john

