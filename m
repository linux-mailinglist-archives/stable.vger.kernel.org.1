Return-Path: <stable+bounces-183421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1A0BBD8B1
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 11:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F063BA84A
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B181C21C9F4;
	Mon,  6 Oct 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cOSCDv3Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB5217F53;
	Mon,  6 Oct 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744604; cv=none; b=XFt/t12Zxb/tftA0qx/tvqYKLlHBDuEvjhpCFl/Qxaq8/ROfVFDQOWEtwSS69T6DcdhSN1H0RX+mkQZTI7DcZpQnYGiimgpCAdhdM3ZfGCFu22K0z13u0Vd5bbreB8fBLThl7GxA3TjWadYH7tTreerb2JrNYSP/ohrkE8BKSWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744604; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpy8IOsbYsj42Nhc/REOQ0z516m0cvBYnR0QV/EpSKX+SN/mrkYKNrDjR8ehdACdqTBYQcPAgwXW4lOibJM+TspjQJYwdhUnJQgrJHD9u81wXgIh7rGRg9WlcoKF55mtaYPYwsvDdbd6mBYpdL6L3OW2Epwbq2D3n2PeQ87qA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOSCDv3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF231C4CEF5;
	Mon,  6 Oct 2025 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759744604;
	bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOSCDv3YFhdim28x/tnf24NYfTP0yLIGL6tBev80rO8Kqi5V8+f5sa5GTAOLD0/vF
	 ZI8w2DadF+dmowyQ0mf0NuPvIqQ3CWbb688g8WEgHrLaQ8TMA76bLeo/d9PvcZKrV3
	 KS3BEfhNczkyEBnfq8wRPelzzrBrw871Nvmw7Q7A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.17.1
Date: Mon,  6 Oct 2025 11:56:33 +0200
Message-ID: <2025100633-throwback-hamper-921e@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100633-update-gown-60c0@gregkh>
References: <2025100633-update-gown-60c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


