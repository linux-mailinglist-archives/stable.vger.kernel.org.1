Return-Path: <stable+bounces-139506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB84AA785F
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 19:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6419E3CA8
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831991AAA11;
	Fri,  2 May 2025 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t4AanCGv"
X-Original-To: stable@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD21A0BFA;
	Fri,  2 May 2025 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206003; cv=none; b=CLEgwknmEeeBW9ZFz2EToODKUCvKfkAI5bie92sghiOFaoylEC6EHf1M5XLitNnseUWmjwakFGndm6enNF0eLR6isvyCwwpCXlyY3G04Ubna83nzvNSxCcj8a4N4Qqs6A6zF+kVzU+xjA6tkSiL3gfDNYaV3eHLp4OvhdmdqvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206003; c=relaxed/simple;
	bh=44Qu48lHB4fRdAZURnFn9uTMB6PP2r+CsQti1RkiD2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk5GBU2LBQOE7liA6sPquKY1KsugDe/8LY/kFhSxhGZaQbI43Uo5axCP97DY27izSX0hV79OrcL8DYOfjYpcZlP3szQ5MnC7lBeUnb5OK+RVhsF7Wd3mdG7zdeDu2WETzBEQVcWdjcKwfXEzIk0UzdkvfBu5E4vfP2Cw0hIiV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=t4AanCGv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p8tAjozIfQA0TAt69y3uSYXciDCOXKGSdjD6jRMBMNo=; b=t4AanCGvkpTyGHwgipJn+LIBZh
	vEDagLp+q7pwzbScLKVONe8MUxFk9DO0E7/WsqcDaZEDDIzxfFhnsxdPH7QCO1BrLoUqlqtQ003rb
	QXvLUCGK4FQ0nd/4CEhxDp14X3M1v9rYmfWqdQbgzfUGXd/SJliE+XAWZ2w6SQ1HdL6pmavPwLj3e
	yO+3H4QnVt5fkLD3INNXOBnKQGZxZYAlfqxgpYLrIgdASgPP1RSbL4wJ/e0gL75LeuVsyGdsu9od7
	YgjITrCt9RzhhxBIXaZDoeKFMLbg4KdmMeaTjE92OcDutPFDCrihDXBrmyV66FrRfvWi+VzlkaYo3
	2ej+Qz2g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAtwq-00000001tPf-0AJt;
	Fri, 02 May 2025 17:13:16 +0000
Date: Fri, 2 May 2025 18:13:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrey Kriulin <kitotavrik.s@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrey Kriulin <kitotavrik.media@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: minix: Fix handling of corrupted directories
Message-ID: <20250502171316.GY2023217@ZenIV>
References: <20250502165059.63012-1-kitotavrik.media@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502165059.63012-1-kitotavrik.media@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 02, 2025 at 07:50:57PM +0300, Andrey Kriulin wrote:
> If the directory is corrupted and the number of nlinks is less than 2 
> (valid nlinks have at least 2), then when the directory is deleted, the
> minix_rmdir will try to reduce the nlinks(unsigned int) to a negative
> value.
> 
> Make nlinks validity check for directory in minix_lookup.
 
Not sure it's a good mitigation strategy - if nothing else, doing that
on r/o filesystem is clear loss...

