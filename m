Return-Path: <stable+bounces-144886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC68ABC4A0
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 18:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6783BD7AC
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B72874F7;
	Mon, 19 May 2025 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VL1gsLmv"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E41EDA26
	for <stable@vger.kernel.org>; Mon, 19 May 2025 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672447; cv=none; b=Poz3zbFbTzm360ERfzElARNPNd1W7zLxnS0b0BTeQZ2I5G0euoVtW4sneLZTDQy6RbTeOc8wQDM4c7PzhefmKmGMvo1hLxNECND7kzzzJ9LEWir7Mj4y5L7IWTOkiIbwyQEl9lZN+1aBSD8QyRNjfQgh5oEDhkNlCFY65mKozAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672447; c=relaxed/simple;
	bh=Rz0Ygcsg66yyp+iUSTdLVQnwCZ6pysVLuKcVZFmXaYo=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=WoQXIupuwKpqy5Lb+MShbOZy83K1P8oRDfjDb9GY4n3sNkk7MneYV6I6eIKuSWa0IT3kLRNXBP65+6IzBGbRYHbd9VEKy8qLVL2SDmcCDetEiqVOUaleavbmSZofAjB8rNKxtC4xBlsYmUX0w2VmMS+hlV2nVzzSkuRLRd9+ymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VL1gsLmv; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 32BF01039728C;
	Mon, 19 May 2025 18:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747672443; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Rz0Ygcsg66yyp+iUSTdLVQnwCZ6pysVLuKcVZFmXaYo=;
	b=VL1gsLmv07yPlblj23+DfZa8niKC4avUee0rkFfbbAxxov5RydMTi0HkInc/boLgfE9EfA
	xt6Se/mj4uJmiqyjVCWW/X+P71ppdpRB1lUn+/dtPaZ48hC0B1vEoO9T9cgODjs4LYsSHN
	diiJO1Eo1OHhaBNfPO7CZxO/kN2fOquvBLGa1Gzin0eOwa06XzBJ5zIwezDENsErYHmsBY
	eWWlzADZhwJ6I/dnhvxF00oYT1/SnP0xYOWud85rEe51o0G2TjmFw+bvZn0WC84ukrzIGu
	V8j3vp2qGZOqyfFm6hXf69jMNyJxZ6BivFoClb2uvMqDzuLDpg2nO0Zioxm3jg==
From: "Fabio Estevam" <festevam@denx.de>
In-Reply-To: <2025051942-glamour-overrule-508c@gregkh>
Content-Type: text/plain; charset="utf-8"
References: <2025051936-qualify-waged-4677@gregkh>
 <136-682b3480-1-3097af80@2841359> <2025051942-glamour-overrule-508c@gregkh>
Date: Mon, 19 May 2025 18:34:01 +0200
Cc: javierm@redhat.com, tzimmermann@suse.de, stable@vger.kernel.org, festevam@gmail.com
To: "Greg KH" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <129-682b5d80-3-1bef5560@16572480>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_FAILED=3A?= patch =?utf-8?q?=22[PATCH]?=
 =?utf-8?q?_drm/tiny=3A?==?utf-8?q?_panel-mipi-dbi=3A?= Use 
 =?utf-8?q?drm=5Fclient=5Fsetup=5Fwith=5Ffourcc()=22?= failed to apply to 
 =?utf-8?q?6=2E12-stable?= tree
User-Agent: SOGoMail 5.12.0
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hi Greg,

On Monday, May 19, 2025 10:53 -03, Greg KH <gregkh@linuxfoundation.org>=
 wrote:

> Can you send these as a patch series for us to consider applying?

I have just submitted the three patches that fix the panel-mipi-dbi reg=
ression on 6.12.

Thanks


