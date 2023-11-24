Return-Path: <stable+bounces-94-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACB17F6A5E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 03:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687862818B9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12D8659;
	Fri, 24 Nov 2023 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="DJLsgCEm"
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Nov 2023 18:02:09 PST
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C83D71
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 18:02:09 -0800 (PST)
Message-ID: <cbe899ddc4bfc2835fc015eb0badfc10@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1700791017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJngGI/8gYBoIQzzTwa021W9RBZPjtuvacLuZX4Apew=;
	b=DJLsgCEm/c4JXm5uEyj0srHAHgJAZDEdVRETyAh4Jo6v+7Kq+z9AI0M3HTdM9ai1M1BU22
	S6eB+DoCntEWp+qo4qwvTQ9rxcF94IuLGxNcL5l/FINxTBy5sZMnLTQvNuKgCOVVeKkR6J
	WT5YLbUosXekXNsUD59hM/wUKn8FUdApNHACaGdRWKRXiSnqnyW1D80NYl1+vA+uLNmXeu
	T7JCB6s9so3jshI2cx609ipVLIzkOF/EaoRQdr5wWKaAUTdn+Nr+DrCBa1dhjp1lJM8FnD
	ffgp1wBkujMnwOYfzHJUBbNeTnOyFdiTVJJnsboFmGKLdDcgtGVMBf5qAp8GAg==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1700791017; a=rsa-sha256;
	cv=none;
	b=mnWj9WunUQfr3ilUu8deZfE7/CWUOaJAQS9R+ACE+M837kDiCqmHcscg0Ip5NIIvN+MyIj
	p3UjUTbvpFQkzyIElaHoHoNB2dshiYAVXyh4ePP1gs5+RKYce36OLv2ioqef7McSaiDZn9
	LiM3YNUkUcXZJuhseaffx8kw5WoQmb8KpLlCT9DlFEMTjN/kCVsLxOEG63S658i3pBkKhZ
	Ygk2ZFnyFiQ7Egm5j3L4BmtTcJ4QIORWzzPe+2gqIAEtTdXDFe5xZrxj8PiTHjHFN0293g
	3D+lL5tZpINsYDfcbW8macbfaLVSxkp9hpINc2qbXPyPgoaj4Tl3JlUgoZzPEQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1700791017; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJngGI/8gYBoIQzzTwa021W9RBZPjtuvacLuZX4Apew=;
	b=lbIU/dAdA++gTzW7FiNZvWg4qA8alHcVhaIfeknRqkIOGxoR+2uwL17mi39tCsISSDT+D3
	Wr9zh5gT0eyyctx25GjuqUP/UjH81UXHReRsRdkG+NQUzY0fZ2jDd1S/I65wP7s6gBN69B
	eHzzrE7vVPCq/jPvoNZDFn0ISf+JN37VE3l6BfJ2EvwkpNV1p9FlWqM8RiUqaaS4wa5fSe
	U5V8I4KgTOgQFgsstFeHaS9izW4Nc5uIqkxUlTGtg5fvIcpp8OPhs7iPgXP7deoGjLpu9i
	JUZgLa53NNTkUP2AP5zMt9poX3v6f7KWfzIlyolB2G2b/HLHfwBdPoeFpSy4pQ==
From: Paulo Alcantara <pc@manguebit.com>
To: Eduard Bachmakov <e.bachmakov@gmail.com>, stable@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>
Subject: Re: Unexpected additional umh-based DNS lookup in 6.6.0
In-Reply-To: <CADCRUiN=tz85t5T00H1RbmwSj_35j9vbe92TaKUrESUyNSK9QA@mail.gmail.com>
References: <CADCRUiNvZuiUZ0VGZZO9HRyPyw6x92kiA7o7Q4tsX5FkZqUkKg@mail.gmail.com>
 <d2c0c53db617b6d2f9b71e734b165b4b.pc@manguebit.com>
 <CADCRUiNSk7b7jVQrYoD153UmaBdFzpcA1q3DvfwJcNC6Q=gy0w@mail.gmail.com>
 <482ee449a063acf441b943346b85e2d0.pc@manguebit.com>
 <CADCRUiN=tz85t5T00H1RbmwSj_35j9vbe92TaKUrESUyNSK9QA@mail.gmail.com>
Date: Thu, 23 Nov 2023 22:56:53 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stable team,

Eduard Bachmakov <e.bachmakov@gmail.com> writes:

> I noticed this got pulled into 6.7. Given this is a user-facing
> regression, can this be proposed for the next 6.6 point release?
> Sorry, if this is already the case and I missed it.

Could you please backport

        5e2fd17f434d ("smb: client: fix mount when dns_resolver key is not available")

to v6.6.y?

Thanks.

